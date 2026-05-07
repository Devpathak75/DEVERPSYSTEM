<%@ page import="com.collegeerp.dao.NoticeDAO" %>

<%
    int id = Integer.parseInt(request.getParameter("id"));
    NoticeDAO dao = new NoticeDAO();
    dao.deleteNotice(id);

    response.sendRedirect("notice.jsp");
%>
