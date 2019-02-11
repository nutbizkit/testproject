<?php
$Token = "rOdBTNjED0VnfuT7Id97xpvOQrUinehoGT2iTN0dFDS";
$message = "Hey nut client is already finish the check-in please go to see the client now!";
echo ('test');
function line_notify($Token, $message) {
	
	$lineapi = $Token;
	
	$mms =  trim($message);
	$imgthumb = "http://www.sednasystem.com/img/Admin/sedna-logo-admin.png";
	$imgfull = "http://www.sednasystem.com/dashboard/img/lycan-qnd-dashboard-logo3.png";
	date_default_timezone_set("Asia/Bangkok");
	$chOne = curl_init(); 
	curl_setopt($chOne, CURLOPT_URL, "https://notify-api.line.me/api/notify"); 
	// SSL USE 
	curl_setopt($chOne, CURLOPT_SSL_VERIFYHOST, 0); 
	curl_setopt($chOne, CURLOPT_SSL_VERIFYPEER, 0); 
	//POST 
	curl_setopt($chOne, CURLOPT_POST, 1); 
	curl_setopt($chOne, CURLOPT_POSTFIELDS, "message=$mms&imageThumbnail=$imgthumb&imageFullsize=$imgfull"); 
	curl_setopt($chOne, CURLOPT_FOLLOWLOCATION, 1); 
	$headers = array( 'Content-type: application/x-www-form-urlencoded', 'Authorization: Bearer '.$lineapi.'', );
  curl_setopt($chOne, CURLOPT_HTTPHEADER, $headers); 
	curl_setopt($chOne, CURLOPT_RETURNTRANSFER, 1); 
	$result = curl_exec( $chOne ); 
	//Check error 
	if(curl_error($chOne)) {
  	echo 'error:' . curl_error($chOne); 
	} else {
		$result_ = json_decode($result, true); 
//		echo "status : " .$result_['status'];
//		echo "message : " . $result_['message'];
		$arr = array(
			'status' => $result_['status'],
			'message' => $result_['message'],
		);
		echo json_encode($arr);
  }
	curl_close( $chOne );   
}

line_notify($Token, $message);
?>