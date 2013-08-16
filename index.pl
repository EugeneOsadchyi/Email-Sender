#!/usr/bin/perl -w
use strict;
use CGI;

print "Content-type: text/html\n\n";

my $cgi = CGI->new();

print <<EOT;
<!DOCUMENT html>
<html lang="en">
	<head>
		<title>E-Mail Sender</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<script type="text/javascript">
		EnableSubmit = function(val)
		{
		    var sbmt = document.getElementById("Accept");

		    if ((val.checked ^ document.getElementById("2").value) != 0)
		    {
		        sbmt.disabled = true;
		    }
		    else
		    {
		        sbmt.disabled = false;
		    }
		}       
		</script>
	</head>
	<body>
		<script src="http://code.jquery.com/jquery.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<div class="container">
			<div class="page-header">
				<h1>E-Mail Sender <small>Send free e-mail to your friends</small>
			</div>
		</div>
		<div class="container">
EOT
		if($cgi->param('result') eq 'success')
		{
			print '<div class="alert alert-success">Email sended successfully.</div>';
		}
		elsif($cgi->param('result') eq 'fail')
		{
			print '<div class="alert alert-error">Email sending failed. ' . $cgi->param('comment') . '</div>';
		}
print <<EOT;
			<form class="navbar-form"  enctype="multipart/form-data" action="send.pl" Method="POST">
				<pre>From:   <input type="text" name="from" value="" size="30" maxlength="50" required>
To:     <input type="text" name="to" value="" size="30" maxlength="50" required>
Theme:  <input type="text" name="subject" value="" size="30" maxlength="50">

<textarea name="body" rows="10" value="" style="width: 900px"></textarea>
EOT
my $box = int(rand(2));
my $str = int(rand(2));

print '<input type="checkbox" value="" ' . (($box)?"checked":"") . ' onClick="EnableSubmit(this)" >I\'m' . (($str)?" not":"") . ' spam bot.';
print '<br><input type="submit" id="Accept" class="btn btn-primary" data-loading-text="Sending..." value="Send mail" '. (($box xor $str)?" disabled": "") .'> <input type="reset" class="btn" value="Clear"><input type="hidden" id="2" value="' . $str .'">';
print<<EOT;
				</pre>
			</form>
		</div>
	</body>
</html>
EOT
