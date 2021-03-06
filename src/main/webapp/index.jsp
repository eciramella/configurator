<%@ page import="com.netflix.astyanax.connectionpool.exceptions.*, com.netflix.astyanax.*, com.netflix.astyanax.connectionpool.*, com.netflix.astyanax.model.*, com.netflix.astyanax.util.*" %>
<html>
<head>
<link type="text/css" href="css/ui-lightness/jquery-ui-1.8.23.custom.css" rel="Stylesheet" />	
<script type="text/javascript" src="js/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.8.23.custom.min.js"></script>
</head>
<body>
<h2>Configuration Service!</h2>
<jsp:useBean id="lister" class="com.configurator.utils.PropertyListingBean" scope="session" >
</jsp:useBean>
<%

//OperationResult<ColumnList<String>> result = lister.getKeyspace().prepareQuery(lister.getColumnFamily()).getKey("db.user").execute();
//ColumnList<String> columns = result.getResult();


//OperationResult<Rows<String, String>> result = lister.getKeyspace().prepareQuery(lister.getColumnFamily()).getKeySlice("db.port").execute();
//String type = columns.getColumnByName("type").getStringValue();
//String value = columns.getColumnByName("value").getStringValue();

//out.println("type -> " + type + "</br>  value -> " + value);
//for (Column<String> c : result.getResult()) {
//     out.println("</br>"+c.getName());
//}
/*
for (Row<String, String> row : result.getResult()) {
  out.println("row key ->"+row.getKey());
  for (Column<String> column : row.getColumns()) {
  out.println("</br> column " + column.getName() + " getStringValue ->"+column.getStringValue());
  }
}
*/
OperationResult<Rows<String, String>> result;
result = lister.getKeyspace().prepareQuery(lister.getColumnFamily()).searchWithIndex().setLimit(100).addExpression().whereColumn("type").equals().value("db_connection_details").execute();

// This will never throw an exception
/*
for (Row<String, String> row : rows.getResult()) {
    out.println("ROW: " + row.getKey() + " " + row.getColumns().size());
}
*/
/*
for (int i = 0; i < rows.size(); i++)
{
   out.println("Row: " +  rows.getRowByIndex(i));
}*/
%>
<script>
	$(function() {
		$( "#tabs" ).tabs();
	});
	</script>



<div class="demo">

<div id="tabs">
	<ul>
		<li><a href="#tabs-1">DB Connection Details</a></li>
		<li><a href="#tabs-2">Feature Settings</a></li>
		<li><a href="#tabs-3">Other</a></li>
	</ul>
	<div id="tabs-1">
<%
for (Row<String, String> row : result.getResult()) {
  out.println("</br> <input value="+row.getKey()+">");
  for (Column<String> column : row.getColumns()) {
  //out.println("</br> column " + column.getName() + "</br>  value <input value="+column.getStringValue()+">");
  if (column.getName().equals("value"))
{
  out.println("<input value="+column.getStringValue()+">");
}
  }
  out.println("<input type=\"submit\" value=\"save\">");
  out.println("<input type=\"submit\" value=\"delete\">");
}
%>
	</div>
	<div id="tabs-2">
		<p>Morbi tincidunt, dui sit amet facilisis feugiat, odio metus gravida ante, ut pharetra massa metus id nunc. Duis scelerisque molestie turpis. Sed fringilla, massa eget luctus malesuada, metus eros molestie lectus, ut tempus eros massa ut dolor. Aenean aliquet fringilla sem. Suspendisse sed ligula in ligula suscipit aliquam. Praesent in eros vestibulum mi adipiscing adipiscing. Morbi facilisis. Curabitur ornare consequat nunc. Aenean vel metus. Ut posuere viverra nulla. Aliquam erat volutpat. Pellentesque convallis. Maecenas feugiat, tellus pellentesque pretium posuere, felis lorem euismod felis, eu ornare leo nisi vel felis. Mauris consectetur tortor et purus.</p>
	</div>
	<div id="tabs-3">
		<p>Mauris eleifend est et turpis. Duis id erat. Suspendisse potenti. Aliquam vulputate, pede vel vehicula accumsan, mi neque rutrum erat, eu congue orci lorem eget lorem. Vestibulum non ante. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Fusce sodales. Quisque eu urna vel enim commodo pellentesque. Praesent eu risus hendrerit ligula tempus pretium. Curabitur lorem enim, pretium nec, feugiat nec, luctus a, lacus.</p>
		<p>Duis cursus. Maecenas ligula eros, blandit nec, pharetra at, semper at, magna. Nullam ac lacus. Nulla facilisi. Praesent viverra justo vitae neque. Praesent blandit adipiscing velit. Suspendisse potenti. Donec mattis, pede vel pharetra blandit, magna ligula faucibus eros, id euismod lacus dolor eget odio. Nam scelerisque. Donec non libero sed nulla mattis commodo. Ut sagittis. Donec nisi lectus, feugiat porttitor, tempor ac, tempor vitae, pede. Aenean vehicula velit eu tellus interdum rutrum. Maecenas commodo. Pellentesque nec elit. Fusce in lacus. Vivamus a libero vitae lectus hendrerit hendrerit.</p>
	</div>
</div>

</div><!-- End demo -->



<div style="display: none;" class="demo-description">
<p>Click tabs to swap between content that is broken into logical sections.</p>
</div><!-- End demo-description -->
</body>
</html>
