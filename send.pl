#!/usr/bin/perl -w
use Net::SMTP::SSL;
use CGI;
use strict;

my $cgi = CGI->new();

my $smtp = Net::SMTP::SSL->new('smtp.gmail.com',
                    Port=> 465,
                    Timeout => 20,
                    Hello=>'user@gmail.com' #your Gmail mail
                    )or (print $cgi->redirect('index.pl?result=fail&comment=Connection failed.') and die "Can not connect\n");;

#print $smtp->domain,"\n";

my $sender = 'user@gmail.com'; #your Gmail mail
my $password = 'password'; #your Gmail password
$smtp->auth ( $sender, $password ) or (print $cgi->redirect('index.pl?result=fail&comment=Authentication failed.') and die "Can not authenticate\n");

my $receiver =  $cgi->param('to');
my $from = $cgi->param('from');

my $subject = $cgi->param('subject');
my $body = $cgi->param('body');

$smtp->mail($sender);
$smtp->to($receiver);
$smtp->data();
$smtp->datasend("To: $receiver <$receiver> \n");
$smtp->datasend("From: $from <$from> \n");
$smtp->datasend("Content-Type: text/html \n");
$smtp->datasend("Subject: $subject");
$smtp->datasend("\n");
$smtp->datasend("$body");
$smtp->dataend();
$smtp->quit();

print $cgi->redirect('index.pl?result=success');
