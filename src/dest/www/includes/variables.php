<?php 
$app = "couchpotato";
$appname = "CouchPotato";
$appversion = "3.0.1";
$appsite = "https://couchpota.to/";
$apphelp = "https://couchpota.to/forum/viewforum.php?f=4";

$applogs = array("/tmp/DroboApps/".$app."/log.txt",
                 "/tmp/DroboApps/".$app."/CouchPotato.log");

$appprotos = array("http");
$appports = array("8083");
$droboip = $_SERVER['SERVER_ADDR'];
$apppage = $appprotos[0]."://".$droboip.":".$appports[0]."/";
if ($publicip != "") {
  $publicurl = $appprotos[0]."://".$publicip.":".$appports[0]."/";
} else {
  $publicurl = $appprotos[0]."://public.ip.address.here:".$appports[0]."/";
}
$portscansite = "http://mxtoolbox.com/SuperTool.aspx?action=scan%3a".$publicip."&run=toolpage";
?>
