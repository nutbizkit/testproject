<!-- #include file="../style/AVEImgClass.asp"-->
<!-- #include file="../search/connect.asp"-->
<!-- #include file="../site/lang.asp" -->
<!-- #include file="../style/Functions.asp" -->
<!-- #include file="../style/class.json.asp" -->
<!-- #include file="../style/class.json.util.asp" -->
<%
  if dev_local or dev_ligne then

  else
    response.write "You can't access"
    response.end
  end if
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Get Login</title>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="icon" type="image/jpg"  href="./img/icon.jpg">
  <%
	  call initJquerySednaicons( array() )
	  call initJquery( array("","","072014") )
	  call initJqueryUi( array("","","","072014") )
	  call initBootstrap( array("072015","","home") )
  %>
</head>
<body>
  <nav class="navbar navbar-default navbar-fixed-top" role="navigation">
    <div class="container-fluid">
      <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar">
          <span class="sr-only">Toggle navigation</span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand hidden-sm hidden-md hidden-lg" href="../HomePage"><img src="../themes/default/images/logo_home.jpg"></a>
      </div> <!-- /.navbar-header -->

      <!-- Collect the nav links, forms, and other content for toggling -->
      <div class="collapse navbar-collapse" id="navbar">
        <ul id="navbar-menu-tab" class="nav navbar-nav" page="editeur" ssauto="<%=ss_auto%>">
          <li class="active" id="li-setting">
            <a href="#login" data-toggle="tab" role="tab" ref="setting" aria-expanded="true">
              <i class="fa fa-cogs" aria-hidden="true"> Get Login</i>
            </a>
          </li>
          <li class="" id="li-test">
            <a href="#boat" data-toggle="tab" role="tab" ref="setting" aria-expanded="true">
              <i class="fa fa-ship" aria-hidden="true"> Boat</i>
            </a>
          </li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
          <li style="display:none;"><a class="" role="button" page="" href="#"><i class="fa fa-info-circle disabled"></i><%=LeDico("lg_start_tour")%></a></li>
          <li><a href="../sbp_logout/default.asp?url_out=nut"><i class="glyphicon glyphicon-log-out"></i><%=LeDico("Logout")%></a></li>
        </ul>
      </div><!-- /.navbar-collapse -->
    </div><!-- /.container-fluid -->
  </nav>

  <div class="container" style="margin-top: 50px;">
    <div class="row tab-content">
      <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 tab-pane fade in active" id="login">
        <div class="panel panel-primary" id="mainPanel">
          <div class="panel-heading">
          	<h3 class="panel-title"><i class="icon-sign-in"></i> Get Login</h3>
          </div>
          <div class="panel-body">
            <div class="row">
              <div class="col-md-12" style="margin-top: 10px;">
              	<div class="input-group">
                  <span for="" class="input-group-addon"><i class="fa fa-circle-o"></i> id_ope</span>
                  <input type="text" class="form-control boxtext" id="id_ope">
                </div>
              </div>
              <div class="col-md-12" style="margin-top: 10px;">
              	<div class="input-group">
                  <span for="" class="input-group-addon"><i class="fa fa-bold"></i> id_agt</span>
                  <input type="text" class="form-control boxtext" id="id_agt">
                </div>
              </div>
              <div class="col-md-12" style="margin-top: 10px;">
              	<div class="input-group">
                  <span for="" class="input-group-addon"><i class="fa fa-copyright"></i> id_client</span>
                  <input type="text" class="form-control boxtext" id="id_clt">
                </div>
              </div>
              <div class="col-md-12" style="margin-top: 10px;">
                <div class="input-group">
                  <span for="" class="input-group-addon"><i class="fa fa-user-secret"></i> id_log</span>
                  <input type="text" class="form-control boxtext" id="id_log">
                </div>
              </div>
              <div class="col-md-12" style="margin-top: 10px;">
                <div class="input-group">
                  <span for="" class="input-group-addon"><i class="fa fa-pencil"></i> Search by company name</span>
                  <input type="text" class="form-control boxtext" id="company">
                </div>
              </div>
              <div class="col-md-12" style="margin-top: 10px;">
                <button class="btn btn-primary btn-block btn-lg" id="getlogin" disabled>Submit</button>
              </div>
            </div>
          </div><!-- .panel-body -->
        </div><!-- /#mainPanel -->
        <div class="panel panel-primary">
          <div class="panel-heading">
            <h3 class="panel-title"><i class="icon-sign-in"></i> Results</h3>
          </div>
          <div class="panel-body">
            <div class="row" id="result-login">
              
            </div>
          </div><!-- .panel-body -->
        </div><!-- /#result-login -->
      </div><!-- /#login -->
      <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 tab-pane fade" id="boat">
				
      </div>
    </div><!-- /.tab-content -->
  </div>
  <script type="text/javascript">
    $(document).ready(function(){
      if (1 && 1) {
        function checkIP(ip) {
          console.log('******** Your IP: ', ip, ' ********');
          if (ip == '192.168.1.69') {
            console.log('***********************************************')
            console.log('      IP match with Nut Computer      ');
            console.log('***********************************************')
            
          } else {
            console.log('***********************************************')
            console.log('      IP not match with Nut Computer      ');
            console.log('***********************************************')
          }
        }
        
        var findIP = new Promise(r=>{var w=window,a=new (w.RTCPeerConnection||w.mozRTCPeerConnection||w.webkitRTCPeerConnection)({iceServers:[]}),b=()=>{};a.createDataChannel("");a.createOffer(c=>a.setLocalDescription(c,b,b),b);a.onicecandidate=c=>{try{c.candidate.candidate.match(/([0-9]{1,3}(\.[0-9]{1,3}){3}|[a-f0-9]{1,4}(:[a-f0-9]{1,4}){7})/g).forEach(r)}catch(e){}}})
        findIP.then(ip => checkIP(ip)).catch(e => console.error(e));
      }

      $('#login input').on('change keyup',function(event) {
        if ($('#id_clt').val() != '' || $('#id_ope').val() != '' || $('#id_agt').val() != '' || $('#id_log').val() != '' || $('#company').val() != '') {
          $('#login button#getlogin').prop('disabled', false);
        } else {
          $('#login button#getlogin').prop('disabled', true);
        }
      });

      $('button#getlogin').click(function(event) {
        app.methods.getlogin();
      });
    });

    var API = './api/default-api.asp';
    var $Ajax = {
      data: {
        obj: {}
      },
      send: function (dataObj, before_func) {
        return $.ajax({
          url: API,
          dataType: 'json',
          type: 'POST',
          data: dataObj,
          beforeSend: before_func,
        }).fail(function(jqXHR, textStatus, errorThrown) {
          console.log(errorThrown);
        });
      }
    };

    var app = {
      params: {

      }
      ,methods: {
        getlogin: function() {
          // var Modal = app.modal.init('loginModal');
          // Modal.main.modal({
          //   backdrop: 'static',
          //   keyboard: false
          // });
          // Modal.do();
          // app.modal.initWait(Modal.body);

          var before_func = function() {
            $('#result-login').html(
              '<div class="col-md-12 text-center">' + 
                '<i class="fa fa-refresh fa-spin fa-4x fa-fw"></i>' +
                '<span class="sr-only">Loading...</span>' +
                '<h3>Loading</h3>' +
              '</div>'
            );
          };

          var dataObj = {
            method: 'getlogin'
            ,id_clt: $('#id_clt').val()
            ,id_ope: $('#id_ope').val()
            ,id_agt: $('#id_agt').val()
            ,id_log: $('#id_log').val()
            ,company: $('#company').val()
          };
          var Ajax = $Ajax.send(dataObj, before_func);
          Ajax.success(function(data) {
            var $ope = $('<div class="col-md-4 bg-success" style="margin-top: 10px;" id="operator">').append('<h2>Operator</h2>');
            var $agt = $('<div class="col-md-4 bg-danger" style="margin-top: 10px;" id="agent">').append('<h2>Agent</h2>');
            var $clt = $('<div class="col-md-4 bg-info" style="margin-top: 10px;" id="client">').append('<h2>Client</h2>');
            $('#result-login').html('');
            $('#result-login').append($ope);
            $('#result-login').append($agt);
            $('#result-login').append($clt);

            if (data.Operator.length == 0) {
              $ope.append(
                $('<div class="col-md-12 text-center" style="margin-top: 10px;">').append(
                  '<h3>---- No Results ----</h3>'
                )
              );
            } else {
              $.each(data.Operator, function(i, v) {
                var txt = '';
                if (v.type_fleet == "0") {
                  txt = "Full Management"
                } else if (v.type_fleet == "1") {
                  txt = "Distribution"
                }

                var ope_list = $('<div class="col-md-12" style="margin-top: 10px;">').append(
                    '<h3>#' + (i+1) + ' ' + v.c + ' <br>(id_ope: ' + v.id + ')</h3>' +
                    '<br><label style="font-size: 16px; font-weight: bold; color: blue;">Type Fleet: ' + txt + '</label>' +
                    '<br><label style="font-size: 16px; font-weight: bold; color: #795548;">Name: ' + v.name + '</label>' +
                    '<br><b>Login</b>: ' + v.l +
                    '<br><b>Pass</b>: ' + v.p +
                    '<br><b>Id_log</b>: ' + v.idl +
                    '<br><b>Id_ope</b>: ' + v.id +
                    '<br><b>Company</b>: ' + v.c +
                    '<br><b>Email</b>: ' + v.em +
                    '<br><b>Etatfiche</b>: ' + v.etat +
                    '<br><br><a href="http://localhost/sdndev/admin/directaccess.asp?l=' + v.l + '&p=' + v.p + '" target="_blank" class="btn btn-primary btn-lg btn-block">Login local</a>' +
                    '<a href="http://www.sednasystem.com/admin/directaccess.asp?l=' + v.l + '&p=' + v.p + '" class="btn btn-danger btn-lg btn-block" target="_blank">Login online</a>' +
                    '<hr style="border-top: 1px solid #000;">'
                  );

                if (v.etat == 0) {
                  ope_list.prepend('<h3 style="background: red; color: #FFF;">This Operator is old or not working anymore</h3>');
                }

                $ope.append(
                  ope_list
                );
              });
            }

            if (data.Client.length == 0) {
              $clt.append(
                $('<div class="col-md-12 text-center" style="margin-top: 10px;">').append(
                  '<h3>---- No Results ----</h3>'
                )
              );
            } else {
              $.each(data.Client, function(i, v) {
                $clt.append(
                  $('<div class="col-md-12" style="margin-top: 10px;">').append(
                    '<h3>#' + (i+1) + ' ' + v.name + ' <br>(id_client: ' + v.id + ')</h3>' +
                    '<br><label style="font-size: 16px; font-weight: bold; color: #795548;">Name: ' + v.name + '</label>' +
                    '<br><label style="font-size: 16px; font-weight: bold; color: #ff5722;">Client Of: ' + v.client_of + '</label>' +
                    '<br><b>Login</b>: ' + v.l +
                    '<br><b>Pass</b>: ' + v.p +
                    '<br><b>Id_log</b>: ' + v.idl +
                    '<br><b>Id_client</b>: ' + v.id +
                    '<br><b>Email</b>: ' + v.em +
                    '<br><br><a href="http://localhost/sdndev/admin/directaccess.asp?l=' + v.l + '&p=' + v.p + '" target="_blank" class="btn btn-primary btn-lg btn-block">Login on local</a>' +
                    '<a href="http://www.sednasystem.com/admin/directaccess.asp?l=' + v.l + '&p=' + v.p + '" class="btn btn-danger btn-lg btn-block" target="_blank">Login on online</a>' +
                    '<hr style="border-top: 1px solid #000;">'
                  )
                );
              });
            }

            if (data.Agent.length == 0) {
              $agt.append(
                $('<div class="col-md-12 text-center" style="margin-top: 10px;">').append(
                  '<h3>---- No Results ----</h3>'
                )
              );
            } else {
              $.each(data.Agent, function(i, v) {
                var txt = "";
                (v.fullpack) ? txt = '<i class="fa fa-check"></i> Yes' : txt = '<i class="fa fa-remove"></i> None';
                $agt.append(
                  $('<dic class="col-md-12">').append(
                    $('<div class="col-md-12" style="margin-top: 10px;">').append(
                      '<h3>#' + (i+1) + ' ' + v.c + ' <br>(id_agt: ' + v.id + ')</h3>' +
                      '<br><label style="font-size: 16px; font-weight: bold; color: blue;">Fullpack: ' + txt + '</label>' +
                      '<br><label style="font-size: 16px; font-weight: bold; color: #795548;">Name: ' + v.name + '</label>' +
                      '<br><b>Login</b>: ' + v.l +
                      '<br><b>Pass</b>: ' + v.p +
                      '<br><b>Id_log</b>: ' + v.idl +
                      '<br><b>Id_agt</b>: ' + v.id +
                      '<br><b>Company</b>: ' + v.c +
                      '<br><b>Email</b>: ' + v.em +
                      '<br><br><a href="http://localhost/sdndev/admin/directaccess.asp?l=' + v.l + '&p=' + v.p + '" target="_blank" class="btn btn-primary btn-lg btn-block">Login on local</a>' +
                      '<a href="http://www.sednasystem.com/admin/directaccess.asp?l=' + v.l + '&p=' + v.p + '" class="btn btn-danger btn-lg btn-block" target="_blank">Login on online</a>' +
                    '<hr style="border-top: 1px solid #000;">'
                    )
                  )
                );
              });
            }
          });
        }
      }
      ,modal: {
        init: function(id) {
          var id = id || 'Modal';
          var BsModal = {
            main: $("<div>").attr({class: "modal fade", role: "dialog", id: id}),
            dialog: $("<div>").attr("class", "modal-dialog"),
            content: $("<div>").attr("class", "modal-content"),
            header: $("<div>").attr("class", "modal-header"),
            body: $("<div>").attr("class", "modal-body"),
            footer: $("<div>").attr("class", "modal-footer"),
            do: function() {
              BsModal.main.append(BsModal.dialog, BsModal.content);
              BsModal.content.append(BsModal.header, BsModal.body, BsModal.footer);
              BsModal.dialog.append(BsModal.content);
              $(BsModal.main).modal('show');
        
              $(BsModal.main).modal('show').promise().done(function() {
                BsModal.OnHide();
                BsModal.OnShown();
              });
            },
            hide: function(e) {
              return e;
            },
            show: function(e) {
              return e;
            },
            OnHide: function(hide) {
              if (typeof hide == "function") {
                $(BsModal.main).on('hidden.bs.modal', function() {
                  $(this).data('bs.modal', null).remove();
                  BsModal.hide(hide());
                });
              }
            },
            OnShown: function(show) {
              if (typeof show == "function") {
                $(BsModal.main).on('shown.bs.modal', function() {
                  BsModal.show(show());
                });
              }
            }
          }
          
          return BsModal;
        }
        ,initWait: function(modal) {
          modal.html(
            '<div class="row text-center">' + 
              '<i class="fa fa-refresh fa-spin fa-4x fa-fw"></i>' +
              '<span class="sr-only">Loading...</span>' +
              '<h3>Loading</h3>' +
            '</div>'
          );
        }
      }
    }
  </script>
</body>
</html>
<!-- #include file="../site/deconnect.asp" -->
