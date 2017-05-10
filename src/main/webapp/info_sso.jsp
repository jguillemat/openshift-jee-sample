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
	<title>ESSI - Show Request info</title>
</head>
<body>
	
	<h1>Mostrando informacion de la peticion ....</h1>
	<hr/>

	<h2>Info ServletContex </h2>
	<hr/>
		<p>application.getServerInfo() = <%= application.getServerInfo() %></p>
	
	<h2>Info Seguridad peticion ...</h2>
	<hr/>
		<p> request.getRemoteUser()    = <%= request.getRemoteUser() %></p>
		<p> request.getUserPrincipal() = <%= request.getUserPrincipal() %></p>

		<%
		Principal myPrincipal = request.getUserPrincipal();
		if ( myPrincipal != null )
		{
			%><p> Principal.class = <%= myPrincipal.getClass().getName() %></p><%
		}
		
		Subject mySubject = null;
		try {
			mySubject = Subject.getSubject( AccessController.getContext() );

		} catch ( Exception ex ) {

		}
		
		if ( mySubject != null )
		{
			%>
			<h3> Subject info .... </h3>
			<p> mySubject.class = <%= mySubject.getClass().getName() %></p>
			<p> mySubject = <%= mySubject %></p>
			<br/>
			<%

			Set myPrincipals = mySubject.getPrincipals();
			if ( myPrincipals != null && !myPrincipals.isEmpty() )
			{
				%><h3> Subject Principals .... </h3><%

				Iterator itP = myPrincipals.iterator();
				int i=0;
				while ( itP.hasNext() )
				{
					Principal p = (Principal) itP.next();
					if ( p!=null ) 
					{
					  i++;
					  %>
					  <p> subject.principal [<%= i %>] = <%= p %></p>
					  <p> subject.principal.class [<%= i %>] = <%= p.getClass().getName() %></p>
					  <%
					}
				}
			}

			Set myPublicCredentials = mySubject.getPublicCredentials();
			if ( myPublicCredentials != null && !myPublicCredentials.isEmpty() )
			{
				%><h3> Subject Public Credentials .... </h3><%

				Iterator itPC = myPublicCredentials.iterator();
				int j=0;
				while ( itPC.hasNext() )
				{
					Object cred = itPC.next();
					if ( cred!=null ) 
					{
					  j++;
					  %>
					  <p> subject.credential [<%= j %>] = <%= cred.toString() %></p>
					  <p> subject.credential.classs [<%= j %>] = <%= cred.getClass().getName() %></p>
					  <%
					}
				}
			}
		}
		%>

	<h2>Info Cookies </h2>
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
