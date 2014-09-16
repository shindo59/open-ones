﻿<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags" %>
<%@ page language="java" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- Menu Horizontal -->
<script type="text/javascript">
$(document).ready(function () {
	$.ajax({
	    url: "response.request.count",
	    dataType: 'json',
	    type: 'GET',
	    success: function (res) {
	    	alert(res.countResponseRequest);
	    	if (res.countResponseRequest > 0) {
	    		$("#countResponse").html("<a class='button blue small' href='listSendRequest' >" + res.countResponseRequest + " New Response </a>");
	    	}
	    	else {
	    		$("#countResponse").html();
	    	}
	    },
	    fail: function() {
	    	alert("FAIL");
	    }
    });
	
	$.ajax({
	    url: "request.count",
	    dataType: 'json',
	    type: 'GET',
	    success: function (res) {
	    	alert(res.countRequest);
	    	if (res.countRequest > 0) {
	    		$("#countRequest").html("<a class='button red small' href='listReceiveRequest' >" + res.countRequest + " New Request </a>");
	    	}
	    	else {
	    		$("#countRequest").html("");
	    	}
	    },
	    fail: function() {
	    	alert("FAIL");
	    }
    });
	
	setInterval(function(){ 
		$.ajax({
		    url: "response.request.count",
		    dataType: 'json',
		    type: 'GET',
		    success: function (res) {
		    	if (res.countResponseRequest > 0) {
		    		$("#countResponse").html("<a class='button blue small' href='listSendRequest' >" + res.countResponseRequest + " New Response </a>");
		    	}
		    	else {
		    		$("#countResponse").html();
		    	}
		    },
		    fail: function() {
		    	alert("FAIL");
		    }
	    });
	}, 90000);
	
	setInterval(function(){ 
		$.ajax({
		    url: "response.request.count",
		    dataType: 'json',
		    type: 'GET',
		    success: function (res) {
		    	if (res.countResponseRequest > 0) {
		    		$("#countResponse").html("<a class='button blue small' href='listSendRequest' >" + res.countResponseRequest + " New Response </a>");
		    	}
		    	else {
		    		$("#countResponse").html();
		    	}
		    },
		    fail: function() {
		    	alert("FAIL");
		    }
	    });
	}, 90000);
});
</script>
<ul class="menu">
	<li class="current"><a href=""><i class="icon-home"></i>Trang chủ</a></li>
  	<li><a href="listAnnouncement"><i class="icon-bullhorn"></i>Thông báo</a></li>
  	<li><a href="listRule"><i class="icon-legal"></i>Quy định</a></li>
	  <li><a href="#"><i class="icon-eye-open"></i>Công việc</a>
	  	<ul>
	      <li><a href="createRequest?model.request.requesttypeCd=Task"><i class="icon-magic"></i>Tạo việc mới</a></li>
	      <li><a href="searchRequest?requestTypeCd=Task"><i class="icon-search"></i>Tìm công việc</a></li>
	      <li class="divider"><a href="mylisttask"><i class="icon-beer"></i>Việc đang làm của tôi</a></li>
	  	</ul>
      </li>
	<li><a href=""  onclick="return false"><i class="icon-magic"></i>Quản lý yêu cầu</a>
		<ul>
			<li><a href="createRequest" ><i class="icon-edit"></i>Tạo mới yêu cầu</a>
			<li><a href="searchRequest" ><i class="icon-search"></i>Tìm kiếm yêu cầu</a>
				<li>
					<a href=""  onclick="return false"><i class="icon-edit"></i>Danh sách yêu cầu</a>
					<ul>
						<li class="left"><a href="listSendRequest"><i class="icon-envelope"></i>Yêu cầu của bạn</a></li>
						<li class="left"><a href="listReceiveRequest"><i class="icon-envelope-alt"></i>Yêu cầu được nhận</a></li>
					</ul>
				</li>
		</ul>
	</li>
	<li style="display: inline-block;" id="countRequest"></li>
	  <li style="display: inline-block; margin-left:10px;" id="countResponse"></li>
	  <li class="right" style="display: inline-block;"><a href="#"><i class="icon-user"></i>${pageContext.request.userPrincipal.name}</a>
	    <ul>
	      <li class="left"><a href="j_spring_security_logout"><i class="icon-coffee"></i>Thoát</a></li>
	    </ul>
	  </li>
	  <s:authorize access="hasRole('ROLE_MANAGER')">
	  
	    <li class="right" style="display: inline-block;"><a href=""><i class="icon-cog"></i>Quản trị</a>
	    <ul>
	      <li class="left"><a href="listLeaveRequest"><i class="icon-desktop"></i>Quản lý đơn nghỉ phép</a></li>
	    </ul>
	  </li>
	  </s:authorize>
	  <%-- For Admin.START --%>
	  <s:authorize access="hasRole('ROLE_ADMIN')">
	  
	    <li class="right" style="display: inline-block;"><a href=""><i class="icon-cog"></i>Cấu hình</a>
	    <ul>
	      <li class="left"><a href="master.department"><i class="icon-sitemap"></i>Phòng ban</a></li>
	      <li class="left"><a href="master.template"><i class="icon-bookmark-empty"></i>Biểu mẫu</a></li>
	      <li class="left"><a href="listLeaveRequest"><i class="icon-desktop"></i>Quản lý đơn nghỉ phép</a></li>
	    </ul>
	  </li>
	  </s:authorize>
  <%-- For Admin.END --%>
</ul>

<!-- End #header -->