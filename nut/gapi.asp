<!--#include file="../search/connect.asp" -->
<!--#include file="../site/lang.asp" -->
<!--#include file="../style/functions.asp" -->
<!-- #include file = "../style/class.json.asp" -->
<!-- #include file = "../style/class.json.util.asp" -->
<html>
  <head>
    <%
      call initJquerySednaicons( array() )
      call initJquery( array("","","072014") )
      call initJqueryUi( array("","","","072014") )
      call initBootstrap( array("072015","","home") )
    %>
    <script src="https://apis.google.com/js/api.js"></script>
    <script>
      var $Ajax = {
        data: {
          obj: {}
        },
        send: function (urlAPI, dataObj, before_func) {
          var me = this;
          var func = before_func || function(){};
          return $.ajax($.extend(true, {}, me.ajaxDefault, {
            url: urlAPI,
            dataType: 'json',
            type: 'POST',
            data: dataObj,
            beforeSend: func,
            idAjax: Math.floor((Math.random() * 1000000) + 1)
          })).fail(function(jqXHR, textStatus, errorThrown) {
            if (jqXHR.status === 405) {
              connect.goLogin(function() {
                app.getSubscription();
                delete window.loginPrompt;
              });
              return;
            }
          });
        },
        ajaxDefault: {
          statusCode: {
            405: function(data) {
              connect.goLogin();
            }
          }
        }
      }

      var connect = {
        data: {
          dict: {
            label_usrname: '<%=jsLeDico("lg_login_label_usrname")%>',
            label_passwd: '<%=jsLeDico("lg_login_label_passwd")%>',
            modal_title: '<%=jsLeDico("lg_login_modal_title")%>',
            btn_login_label: '<%=jsLeDico("lg_login_btn_login_label")%>',
            login_fail_msg: '<%=jsLeDico("lg_login_login_fail_msg")%>',
            login_success_msg: '<%=jsLeDico("lg_login_login_success_msg")%>'
          }, //dict
          sess: {
            id_agt: <%=noNull(array(ss_id_agt,0))%>,
            id_ope: <%=noNull(array(ss_id_ope,0))%>,
            id_auto: <%=noNull(array(ss_auto,0))%>,
            id_log: <%=noNull(array(ss_id_log,0))%>,
            ss_styl: '<%=noNull(array(ss_styl,""))%>'
          } //sess
        }, //data
        goLogin: function(func) {
          if (func) {
            if (typeof loginPrompt === 'undefined') {
              window.loginPrompt = PromptJack.Prompt({
                reload:false,
                specialFunction:true,
                ckPerson: true,
                ss_id_log: this.data.sess.id_log,
                dics: this.data.dict,
                forgetPassword: true,
                createAccount: true
              });
              loginPrompt.setInstructions(func);
              loginPrompt.open('noDefault');
            } else {
              loginPrompt.setInstructions(func);
              loginPrompt.open('noDefault');
            }
          } else { //if (func)
            if (typeof loginPrompt === 'undefined') {
              window.loginPrompt = PromptJack.Prompt({
                dics: this.data.dict,
                forgetPassword: true,
                createAccount: true
              });
              loginPrompt.open('noDefault');
            } else {
              loginPrompt.open('noDefault');
            }
          } //if (func)
        }, //goLogin
        goLogout: function() {
          $.ajax({
            url: '../API/Logout.asp',
            success: function(data) {
              window.loginPrompt = PromptJack.Prompt({
                forgetPassword: true,
                createAccount: true
              });
              loginPrompt.open('noDefault');
            }
          }); 
        } //goLogout
      }; //connect

      var app = {
        data: {
          gapi_url: 'https://accounts.google.com/o/oauth2/auth'
          ,client_id: '763821273055-grj3mssll13i6i3lbf2h0jg1156n385j.apps.googleusercontent.com'
          ,redirect_uri: 'http://' + window.location.hostname + '/sdndev/nut/callback.asp'
        },
        computed: function() {
          this.getCode.call(this);
        },
        getCode: function() {
          // var data = {
          //   scope: 'https://www.googleapis.com/auth/androidpublisher'
          //   ,response_type: 'code'
          //   ,access_type: 'offline'
          //   ,redirect_uri: 'http://3a514f04.ngrok.io/sdndev/nut/callback.asp'
          //   ,client_id: '763821273055-grj3mssll13i6i3lbf2h0jg1156n385j.apps.googleusercontent.com'
          // };
          // var Ajax = $Ajax.send(this.data.gapi_url, data)
        }
      }

      window.location = 'https://accounts.google.com/o/oauth2/auth?scope=https://www.googleapis.com/auth/androidpublisher&response_type=code&access_type=offline&redirect_uri=' + app.data.redirect_uri + '&client_id=' + app.data.client_id;
    </script>
  </head>
  <body>
    <div id="results"></div>
  </body>
</html>
<!-- #include file="../site/deconnect.asp" -->
