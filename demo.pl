	use HVKAPI;
	use Data::Dumper;
	
							# First of all, we create an object. We
							# will set captcha-callback, but leave
							# an application id and useragent to be
							# set to default values
	my $vk = new HVKAPI(\&captchaCallback);
							# Login attempt. Die if error occured.
	my %res = $vk->login('email', 'pass');
	die("Error #$res{errcode}: $res{errdesc}") if ($res{errcode});
	
							# The request itself
	my $resp = $vk->request('getProfiles', {'uids'=>'1,23363'});
	
	print Dumper($resp);				# Shows the response in a structured view.
	print $resp->{response}->[0]->{first_name};  
	
	
sub captchaCallback
{
	my $cvars = shift;
	my $url = $cvars->{captcha_url};
	my $answer;
	
	print "\nHouston, we have a captcha!\n$url\nAnswer: \n";
	$answer = <>;
	chomp $answer;
	
	return $answer;
}

