<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Your application - Default Page</title>

<link href="resources/admin-lte/1.3/css/AdminLTE.css" rel="stylesheet">

<link href="resources/admin-lte/1.3/css/bootstrap.min.css" rel="stylesheet">
<script src="resources/jquery-handsontable/0.11.4/lib/jquery.min.js"></script>
<script src="resources/admin-lte/1.3/js/bootstrap.min.js" type="text/javascript"></script>

<link href="resources/x-editable/1.5.0/css/bootstrap-editable.css" rel="stylesheet">
<script src="resources/x-editable/1.5.0/js/bootstrap-editable.min.js"></script>

</head>
<body>
  <div class="container">
    <%-- header --%>
    <div class="header">
      <tiles:insertAttribute name="header" />
    </div>
    
    <!-- Content -->
    <div class="row">
      <%-- Left part --%>
      <div class="col-lg-9">
        <tiles:insertAttribute name="body-left" />
      </div>
      
      <%--Right part --%>
      <div class="col-lg-3">
        <tiles:insertAttribute name="body-right" />
      </div>
    </div>
    <div class="footer">
      <tiles:insertAttribute name="footer" />
    </div>
  </div>
</body>
</html>