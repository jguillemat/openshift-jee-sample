<%@ page language="java" 
	contentType="text/html; charset=UTF-8"
    	session="true"
    	pageEncoding="UTF-8"
		import="java.util.*,
	      java.security.*,
	      javax.security.auth.*,
	      javax.security.auth.x500.X500Principal"

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>ESSI - Show SSL info</title>
</head>
<body>
	
	<h1>Mostrando informacion SSL ....</h1>
	<hr/>

	<h2>Info ServletContex </h2>
	<hr/>
		<p>application.getServerInfo() = <%= application.getServerInfo() %></p>
	
	<h2>Info Seguridad peticion ...</h2>
	<hr/>
		<p> request.getRemoteUser()    = <%= request.getRemoteUser() %></p>
		<p> request.getUserPrincipal() = <%= request.getUserPrincipal() %></p>

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
	
	

	<%
	if ( request.isSecure() ) 
	{
		%>
		<h2>Info Certificados SSL </h2>
		<hr/>
		<%
		java.security.cert.X509Certificate[] certs = null;
		certs = (java.security.cert.X509Certificate[]) request.getAttribute("javax.servlet.request.X509Certificate");
		
		if (certs != null) 
		{    
			for ( int indice = 0; indice < certs.length; indice ++ )
			{
				java.security.cert.X509Certificate clientCert = certs[ indice ];
				if (clientCert != null) 
				{
					// Get the Distinguised Name for the user.
 					X500Principal subjectPrincipal = clientCert.getSubjectX500Principal();
 					
					%><p> Cert[<%= indice %>].getSubjectDN()= <%= clientCert.getSubjectDN() %> </p><%
					%><p> Cert[<%= indice %>].getSubjectX500Principal() = <%= clientCert.getSubjectX500Principal() %> </p><%
					%><br/><%
						%><p> subjectPrincipal[<%= indice %>].getName() = <%= subjectPrincipal.getName() %> </p><%					
						%><p> subjectPrincipal[<%= indice %>].getName(X500Principal.CANONICAL) = <%= subjectPrincipal.getName(X500Principal.CANONICAL) %> </p><%
 						%><p> subjectPrincipal[<%= indice %>].getName(X500Principal.RFC1779) = <%= subjectPrincipal.getName(X500Principal.RFC1779 ) %> </p><%
						%><p> subjectPrincipal[<%= indice %>].getName(X500Principal.RFC2253 ) = <%= subjectPrincipal.getName(X500Principal.RFC2253 ) %> </p><% 						
						%><p> subjectPrincipal[<%= indice %>].getEncoded() = <%= subjectPrincipal.getEncoded() %> </p><%		
						%><p> subjectPrincipal[<%= indice %>].toString() = <%= subjectPrincipal.toString() %> </p><%										
					%><br/><%			
					%><p> Cert[<%= indice %>].getIssuerDN()            = <%= clientCert.getIssuerDN() %> </p><%
					%><p> Cert[<%= indice %>].getIssuerX500Principal() = <%= clientCert.getIssuerX500Principal() %> </p><%
					%><br/><%
					%><p> Cert[<%= indice %>].getSerialNumber()   = <%= clientCert.getSerialNumber() %> </p><%
					%><p> Cert[<%= indice %>].getTBSCertificate() = <PRE><%= clientCert.getTBSCertificate() %> </PRE></p><%
					%><br/><%
				}
			}
		}
		else
		{
			%><p><font color="red">No hay certificados de cliente en la petitcion.</font></p><%
		}
	}
	else
	{
		%><p><font color="red">LA CONEXION NO ES SEGURA.</font></p><%
	}
	%>

</body>
</html>
