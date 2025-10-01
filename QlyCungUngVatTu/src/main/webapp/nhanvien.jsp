<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Redirect to the servlet that prepares the list of employees
    String ctx = request.getContextPath();
    response.sendRedirect(ctx + "/nhanvien/list");
%>
