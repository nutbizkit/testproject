<!-- #include file="../../search/connect.asp"-->
<!-- #include file="../../site/lang.asp" -->
<!-- #include file="../../style/Functions.asp" -->
<!-- #include file="../../style/class.json.asp" -->
<!-- #include file="../../style/class.json.util.asp" -->
<%
	Response.ContentType = "application/json"
	if dev_local or dev_asia  then
	else
		response.write "{msg: You cannot access this page}"
		' response.end
	end if
	id_ope = Nonull(array(request("id_ope"), 0))
	id_agt = Nonull(array(request("id_agt"), 0))
	id_clt = Nonull(array(request("id_clt"), 0))
	id_log = Nonull(array(request("id_log"), 0))
	company = Nonull(array(request("company"), ""))
	method = Nonull(array(request("method"), ""))
	redirect_uri = request("redirect_uri")
	client_id = request("client_id")
	grant_type = request("grant_type")
	code = request("code")
	client_secret = request("client_secret")

	select case Lcase(method&"")
		case "getlogin"
			getLoginPass()
		case "gettoken"
			getToken()
	end select

	Function getLoginPass()
		cntRow = -1
		SQL_COMPANY = ""
		if company&"a" <> "a" then SQL_COMPANY = " OR Company LIKE '%" & company & "%' "
		SQL = "SELECT DISTINCT sbp.login, sbp.Pass, sbp.Type, sbp.Auto, sbp.id_log, sbp.Pass2, " &_
			" CASE " &_
      "     WHEN sbp.Auto = 2 " &_
      "     THEN ope.Company " &_
      "     WHEN sbp.Auto = 6 " &_
      "     THEN agt.Company " &_
      "     ELSE '' " &_
      " END AS Company, " &_
      " CASE " &_
      "     WHEN sbp.Auto = 2 " &_
      "     	THEN ope.id_ope " &_
      "     WHEN sbp.Auto = 6 " &_
      "     	THEN agt.id_agt " &_
      "     WHEN sbp.Auto = 1 " &_
      "     	THEN clt.id_client " &_
      "     ELSE '' " &_
      " END AS id, " &_
      " CASE " &_
      "     WHEN sbp.Auto = 2 " &_
      "     	THEN ope.email " &_
      "     WHEN sbp.Auto = 6 " &_
      "     	THEN agt.email " &_
      "     WHEN sbp.Auto = 1 " &_
      "     	THEN clt.email " &_
      "     ELSE '' " &_
      " END AS email, " &_
      " CASE " &_
      "     WHEN sbp.Auto = 2 " &_
      "     THEN ope.etatfiche " &_
      "     ELSE '' " &_
      " END AS etatfiche, " &_
      " CASE " &_
      "     WHEN sbp.Auto = 2 " &_
      "     	THEN ope.type_fleet " &_
      "     ELSE '' " &_
      " END AS type_fleet, " &_
	  	" CASE " &_
      "     WHEN sbp.Auto = 2 " &_
      "     THEN ope.Name + ' ' + ope.FirstName " &_
      "     WHEN sbp.Auto = 6 " &_
      "     THEN agt.Name + ' ' + agt.FirstName " &_
      "     WHEN sbp.Auto = 1 " &_
      "     THEN clt.Name + ' ' + clt.FirstName " &_
      "     ELSE '' " &_
      " END AS name, " &_
	  	" CASE " &_
      "     WHEN sbp.Auto = 1 " &_
      "     THEN (select Company from agent where id_agt IN (clt.id_agt)) " &_
      "     ELSE '' " &_
      " END AS client_of " &_
			" FROM sbp_login sbp " &_
			" FULL JOIN Operator ope ON ope.id_log = sbp.id_log " &_
     	" FULL JOIN Agent agt ON agt.id_log = sbp.id_log " &_
     	" FULL JOIN Client clt ON clt.id_log = sbp.id_log " &_
			" WHERE sbp.id_log IN " &_
			" ( " &_
			"     SELECT id_log " &_
			"     FROM Operator ope " &_
			"     WHERE ope.id_ope in(" & id_ope & ") " &_
			SQL_COMPANY &_
			"     UNION ALL " &_
			"     SELECT id_log " &_
			"     FROM Agent agt " &_
			"     WHERE agt.id_agt in(" & id_agt & ") " &_
			SQL_COMPANY &_
			"     UNION ALL " &_
			" 		SELECT id_log " &_
			"     FROM Client clt " &_
			"     WHERE clt.id_client in(" & id_clt & ") " &_
			"     UNION ALL " &_
			"			SELECT id_log " &_
			"			FROM SBP_Login " &_
			"			WHERE id_log in(" & id_log & ") " &_
			" );"
		' response.write SQL : response.end
		rs.open SQL, cn
			if not rs.eof then
				arrRow = rs.getrows()
				cntRow = ubound(arrRow, 2)
			end if
		rs.close
		
		Set JsObj = jsObject()
		Set JsObj("Operator") = jsArray()
		Set JsObj("Agent") = jsArray()
		Set JsObj("Client") = jsArray()
		Set JsObj("God") = jsArray()
		if cntRow > -1 then
			for i=0 to cntRow
				login 	= Nonull(array(arrRow(0, i), ""))
				pass 		= Nonull(array(arrRow(1, i), ""))
				typ 		= Nonull(array(arrRow(2, i), ""))
				auto		= Nonull(array(arrRow(3, i), ""))
				id_log	= Nonull(array(arrRow(4, i), ""))
				pass2		= Nonull(array(arrRow(5, i), ""))
				pass 		= Decrypt(login, pass)
				comp		= Nonull(array(arrRow(6, i), ""))
				id			= Nonull(array(arrRow(7, i), ""))
				email		= Nonull(array(arrRow(8, i), ""))
				etatfiche = Nonull(array(arrRow(9, i), ""))
				type_fleet = Nonull(array(arrRow(10, i), ""))
				name = Nonull(array(arrRow(11, i), ""))
				client_of = Nonull(array(arrRow(12, i), ""))
				Select case auto&""
					case "1"
						obj = "Client"
					case "2"
						obj = "Operator"
					case "4"
						obj = "God"
					case "6"
						obj = "Agent"
						abo_fullpack = 0
						if ModulAccesTab( array("FullPack", "", "", "", "A"&id) ) then abo_fullpack = 1
				end Select
				Set JsObj(obj)(null) = jsObject()
						JsObj(obj)(null)("l") = login
						JsObj(obj)(null)("p") = pass
						JsObj(obj)(null)("type") = typ
						JsObj(obj)(null)("auto") = Auto
						JsObj(obj)(null)("idl") = id_log
						JsObj(obj)(null)("id") = id
						JsObj(obj)(null)("c") = comp
						JsObj(obj)(null)("em") = email
						JsObj(obj)(null)("etat") = etatfiche
						JsObj(obj)(null)("fullpack") = abo_fullpack
						JsObj(obj)(null)("type_fleet") = type_fleet
						JsObj(obj)(null)("name") = name
						JsObj(obj)(null)("client_of") = client_of
			next
		end if
				
		JsObj.flush
	End Function

	function getToken()
		RESOLVE_XMLTIMEOUT = 15000  'in milliseconds 
		CONNECT_XMLTIMEOUT = 30000  'in milliseconds 
		SEND_XMLTIMEOUT    = 30000  'in milliseconds 
		RECEIVE_XMLTIMEOUT = 300000 'in milliseconds 
		
		strData = "redirect_uri="&Server.UrlEncode( redirect_uri )&_
							"&client_id="&Server.UrlEncode( client_id )&_
							"&grant_type="&Server.UrlEncode( grant_type ) &_
							"&code="&Server.UrlEncode( code )&_
							"&client_secret="&Server.UrlEncode( client_secret )
		dim xmlHttp
    Set xmlHttp = Server.Createobject("MSXML2.ServerXMLHTTP.6.0")
    'resolve, connect, send, receive - in milliseconds 
    xmlhttp.setTimeouts RESOLVE_XMLTIMEOUT,CONNECT_XMLTIMEOUT,SEND_XMLTIMEOUT,RECEIVE_XMLTIMEOUT   
    xmlHttp.Open "POST", "https://accounts.google.com/o/oauth2/token", false
    xmlHttp.setRequestHeader "content-type", "application/x-www-form-urlencoded;"
		xmlHttp.setRequestHeader "Content-Length", Len(strData)
    xmlHttp.Send (strData)
    '---------------------------------------------------- 
    '##### [START]Check Error #####'
    xmlResponse = ""
    response.write "<br>xmlHttp.responseText: "&xmlHttp.responseText
    If xmlhttp.readyState = 4 then
      If xmlhttp.status = 200 then
			    xmlResponse = xmlHttp.responseText'xml Response 
			    response.write xmlResponse    
			Else
      	response.write  "Fail[status]: " & xmlhttp.status
      End If
    Else
        response.write  "Fail[readyState]: "&xmlhttp.readyState
    End If
	end function
%>
<!-- #include file="../../site/deconnect.asp" -->