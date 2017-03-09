<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<html>
<head>
    <title><tiles:insertAttribute name="title" ignore="true" /></title>
</head>
<body>
    <form action="/customer_save" method="post">
        <label for="name">Name</label>
        <input type="text" id="name" name="name"/>
        <br/>
        <label for="description">Description</label>
        <input type="text" id="description" name="description"/>
        <br/>
        <input type="submit" value="commit"/>
    </form>
</body>
</html>