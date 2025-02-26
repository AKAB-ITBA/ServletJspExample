<%@page isErrorPage="true" %>

<html>
<body>
<h1>ERROR OCCURRED</h1>
<%=
    exception.getMessage()
%>
</body>
</html>