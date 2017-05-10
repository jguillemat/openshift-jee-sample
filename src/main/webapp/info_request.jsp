<%@ page language="java" 
	contentType="text/html; charset=UTF-8"
    	session="true"
    	pageEncoding="UTF-8"
	import="java.util.*,
		java.security.*,
		javax.security.auth.*,
		javax.servlet.http.Cookie,
		java.security.cert.X509Certificate"

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
		<br/>
		<p> request.isUserInRole("USUARIO") = <%= request.isUserInRole("USUARIO") %></p>
		<p> request.isUserInRole("ADMINISTRADOR") = <%= request.isUserInRole("ADMINISTRADOR") %></p>
		<p> request.isUserInRole("CIUTADA") = <%= request.isUserInRole("CIUTADA") %></p>
		<br/>
		<p> request.isUserInRole("BASE") = <%= request.isUserInRole("BASE") %></p>
		<p> request.isUserInRole("ciutada") = <%= request.isUserInRole("ciutada") %></p>
		<p> request.isUserInRole("fusuaris") = <%= request.isUserInRole("fusuaris") %></p>
		<p> request.isUserInRole("fusuarisbase") = <%= request.isUserInRole("fusuarisbase") %></p>
		<p> request.isUserInRole("fusuaris") = <%= request.isUserInRole("fusuaris") %></p>
		<br/>
		<%
		try {
			Principal myPrincipal = request.getUserPrincipal();
			if ( myPrincipal != null )
			{
				%><p> Principal.class = <%= myPrincipal.getClass().getName() %></p><%
			}
		} catch ( Exception ex ) {

		}
		
		Subject mySubject = null;
		try {
			mySubject = Subject.getSubject( AccessController.getContext() );

		} catch ( Exception ex ) {

		}
		
		if ( mySubject != null )
		{
			try {
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

			} catch ( Exception ex ) {

			}
		}
		%>

	<h2>Info Request </h2>
	<hr/>
		<p> request.getContextPath() = <%= request.getContextPath() %></p>
		<p> request.getQueryString() = <%= request.getQueryString() %></p>
		<p> request.getAuthType() = <%= request.getAuthType() %></p>
		<p> request.getMethod() = <%= request.getMethod() %></p>
		<p> request.getPathInfo() = <%= request.getPathInfo() %></p>
		<p> request.getPathTranslated() = <%= request.getPathTranslated() %></p>
		<p> request.getRemoteUser() = <%= request.getRemoteUser() %></p>
		<p> request.getRequestedSessionId() = <%= request.getRequestedSessionId() %></p>
		<p> request.getRequestURL() = <%= request.getRequestURL() %></p>

		<p> request.getServerName() = <%= request.getServerName() %></p>
		<p> request.getServerPort() = <%= request.getServerPort() %></p>

		<p> request.getRemoteAddr() = <%= request.getRemoteAddr() %></p>
		<p> request.getRemoteHost() = <%= request.getRemoteHost() %></p>
		<p> request.getRemotePort() = <%= request.getRemotePort() %></p>

		<p> request.getLocalName() = <%= request.getLocalName() %></p>
		<p> request.getLocalAddr() = <%= request.getLocalAddr() %></p>
		<p> request.getLocalPort() = <%= request.getLocalPort() %></p>

		<p> request.isSecure() = <%= request.isSecure() %></p>
		<p> request.getProtocol() = <%= request.getProtocol() %></p>
		<p> request.getScheme() = <%= request.getScheme() %></p>


		<p> request.getContentLength() = <%= request.getContentLength() %></p>
		<p> request.getContentType() = <%= request.getContentType() %></p>
		<p> request.getCharacterEncoding() = <%= request.getCharacterEncoding() %></p>


		<p> request.getRequestURI() = <%= request.getRequestURI() %></p>
		<p> request.getRequestURL() = <%= request.getRequestURL() %></p>
		<p> request.getServletPath() = <%= request.getServletPath() %></p>
		<p> request.getSession() = <%= request.getSession().getId() %></p>
		<p> request.isRequestedSessionIdValid() = <%= request.isRequestedSessionIdValid() %></p>
		<p> request.isRequestedSessionIdFromCookie() = <%= request.isRequestedSessionIdFromCookie() %></p>
		<p> request.isRequestedSessionIdFromURL() = <%= request.isRequestedSessionIdFromURL() %></p>
	<br/>

	<h2>Info Request Attributes </h2>
	<hr/>
	<%
        Enumeration attrNames = request.getAttributeNames();
        while (attrNames.hasMoreElements()) 
	{
            	String attrName = (String) attrNames.nextElement();
            	Object attrValue = request.getAttribute( attrName );
		%>
		<p> Request.getAttribute ( "<%= attrName %>" ) =  "<%= attrValue %>" </p>
		<%
        }
	%>
	<br/>

	<h2>Info Request Parameters </h2>
	<hr/>
	<%
        Map parameters = request.getParameterMap();
        Iterator paramNames = parameters.keySet().iterator();
        while (paramNames.hasNext()) 
	{
            	String paramName = (String) paramNames.next();
            	String paramValues[] = (String[]) parameters.get(paramName);
		%>
		<p> Request.PARAMETER = "<%= paramName %>" , "<%= paramValues %>" </p>
		<%
        }
	%>
	<br/>

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
	<br/>

	<h2>Info Headers </h2>
	<hr/>
	<%
        Enumeration names = request.getHeaderNames();
        while (names.hasMoreElements()) 
	{
           	String name = (String) names.nextElement();
           	Enumeration values = request.getHeaders(name);
           	while (values.hasMoreElements()) 
		{
                	String value = (String) values.nextElement();
	       	 	%><p> Request.HEADER = "<%= name %>" , "<%= value %>" </p><%
            	}
        }
	%>
	<br/>

	<h2>Info Locales </h2>
	<hr/>
	<%
        Enumeration locales = request.getLocales();
        while (locales.hasMoreElements()) 
	{
           	Locale locale = (Locale) locales.nextElement();
       		%><p> Request.LOCALE = "<%= locale %>" </p><%
        }
	%>
	<br/>

	<h2>Info Certificados Cliente </h2>
	<hr/>
	<%
	X509Certificate certs[] = (X509Certificate[])request.getAttribute("javax.servlet.request.X509Certificate");  
	if ( certs!=null ) {

		int i = 0;
	   	for (X509Certificate cert : certs) 
		{  
			%><p> <i>Certificado[<%= i %>].getIssuerDN		= "<%=  cert.getIssuerDN() %>" </i></p><%
			%><p> <i>Certificado[<%= i %>].issuerUniqueID 		= "<%=  cert.getIssuerUniqueID() %>" </i></p><%
			%><p> <i>Certificado[<%= i %>].issuerX500Principal 	= "<%=  cert.getIssuerX500Principal() %>" </i></p><%
			%><p> <i>Certificado[<%= i %>].serialNumber()  		= "<%=  cert.getSerialNumber() %>" </i></p><%
			%><p> <i>Certificado[<%= i %>].version		  	= "<%=  cert.getVersion() %>" </i></p><%
			%><p> <i>Certificado[<%= i %>].type		   	= "<%=  cert.getType() %>" </i></p><%
			%><p> <i>Certificado[<%= i %>].signature		= <pre>"<%=  cert.getSignature() %>" </pre></i></p><%

			%><p> Certificado[<%= i %>].SubjectAltName		= "<%=  cert.getSubjectAlternativeNames() %>" </p><%
			%><p> Certificado[<%= i %>].subjectX500Principal() 	= "<%=  cert.getSubjectX500Principal() %>" </p><%
			%><p> Certificado[<%= i %>].subjectUniqueID()      	= "<%=  cert.getSubjectUniqueID() %>" </p><%
			%><p> Certificado[<%= i %>].tbsCertificate		= "<%=  cert.getTBSCertificate() %>" </p><%

			%><br/><%
			i++;
		}  
	}
	%>
	<br/>
	
</body>
</html>
