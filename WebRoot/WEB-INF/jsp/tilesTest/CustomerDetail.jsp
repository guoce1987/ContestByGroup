<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<html>
<head>
    <title><tiles:insertAttribute name="title" ignore="true" /></title>
</head>
<body>
    <h5>Details</h5>
    Name: ${name}<br/>
    Descript: ${description}<br/>
</body>
</html>