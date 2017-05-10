<%@ page language="java" 
	contentType="text/html; charset=UTF-8"
    	session="true"
    	pageEncoding="UTF-8"
	import="java.util.*,
	      java.security.*,
	      javax.security.auth.*,
	      javax.servlet.http.Cookie"

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>ESSI - Show Cookies info</title>
</head>
<body>
	
	<h1>Mostrando informacion de las cookies de la session ....</h1>
	<hr/>

	<h2>Info COOKIES </h2>
	<hr/>
	<%
	Cookie cookies[] = request.getCookies();
        if (cookies != null) 
	{
		for (int i = 0; i < cookies.length; i++) 
		{
			Cookie myCookie = cookies[i];

			%>
			<p> Request.Cookie [<%= i %>] = <%= cookies[i] %> </p>
			<ul>
				<li> Cookie.getName()    = "<%= myCookie.getName() %>" </li>
				<li> Cookie.getDomain()  = "<%= myCookie.getDomain() %>" </li>
				<li> Cookie.getPath()    = "<%= myCookie.getPath() %>" </li>
				<li> Cookie.getSecure()  = "<%= myCookie.getSecure() %>" </li>
				<li> Cookie.getValue()   = "<%= myCookie.getValue() %>" </li>
				<li> Cookie.getVersion() = "<%= myCookie.getVersion() %>" </li>
			</ul>
			<%
		}
        }
	%>

</body>
</html>
