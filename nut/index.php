<?php
	header("Content-Type: application/json");
	$codes = $_REQUEST['code'];
	$serv_local = $_REQUEST['serv_local'];
	$code = urlencode($codes);
	$secret = 'zhgIjueHvBdvUOdbO4s9_Zih';
	$client_id = '763821273055-grj3mssll13i6i3lbf2h0jg1156n385j.apps.googleusercontent.com';
	$redirect_uri = urlencode('http://' . $serv_local . '/sdndev/nut/callback.asp');
	$grant_type = 'authorization_code';
	$url = 'https://accounts.google.com/o/oauth2/token';
	$post = 'code=' . $code . '&client_id=' . $client_id . '&client_secret=' . $secret . '&redirect_uri=' . $redirect_uri . '&grant_type=' . $grant_type;

	$curl = curl_init();
	curl_setopt($curl, CURLOPT_URL, $url);
	curl_setopt($curl, CURLOPT_FOLLOWLOCATION, TRUE);
	curl_setopt($curl, CURLOPT_AUTOREFERER, TRUE);
	curl_setopt($curl, CURLOPT_POST, TRUE);
	curl_setopt($curl, CURLOPT_POSTFIELDS, $post); 
	curl_setopt($curl, CURLOPT_VERBOSE, TRUE);
	curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, FALSE);
	curl_setopt($curl, CURLOPT_RETURNTRANSFER, TRUE);
	$json = curl_exec($curl);
	curl_close($curl);

	echo json_encode($json);
?>