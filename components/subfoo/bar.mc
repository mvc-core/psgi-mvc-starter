<%args>
$.data => sub { {} }
</%args>
<h1>I'm Subfoo / Bar<br>
Hello <% $self->data->{name} // 'Anonymous' %> ??!</h1>

<p>
	<a href="/">Start</a>
</p>

% foreach (sort keys %ENV) {
%	next if /pass/i;
	&bull; <b><% $_ %></b> = <% $ENV{$_} %><br>
% }

<& partials/footer.mc, data=>$self->data &>
