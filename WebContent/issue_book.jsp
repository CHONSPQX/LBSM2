<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Issue Book || LMS</title>
	<link href="css/bootstrap.css" rel="stylesheet">
</head>
<body>

		<div class="container">
       
                 <a class="brand" href="#"></a>
          <h3>Library Management System</h3>
		  <div class="tabbable tabs-below">
			<ul class="nav nav-pills">
		      <li ><a href="index.jsp">Home</a></li>
		      <li class="active"><a href="issue_book.jsp">Issue Book</a></li>
		      <li><a href="return_book.jsp">Return Book</a></li>
              <li><a href="addbook.jsp">Add New Book</a></li>
              <li><a href="book_status.jsp">Book Status</a></li>
              <li><a href="listbook.jsp">Available Books</a></li>
              <li><button class="btn btn-primary" onclick="window.location.href='logout.jsp'">Logout</button></li>
			</ul>
          
	          	
			<ul class="nav nav-list">
            <li class="nav-header"></li>
            <li class="active"><a href="#"></a></li>
            <li><a href="#"></a></li>
            </ul>
          
      

    

		
		 </div><!--/.nav-collapse -->
        </div>
      <div class="container">
    </div>
      
     <div class="navbar navbar-inverse navbar-fixed-bottom">
  <div class="navbar-inner">
     <div class="container">
     <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="active" href="#">Support@lib.com</a>
    </div>
  </div>
</div>

<!-- Wrap all page content here -->
<div id="wrap">
  <div class="container">
 
    <p>Issue Book</p>
    <%@page import="java.sql.*,java.util.*,java.text.SimpleDateFormat,java.util.Date" %>
<%
SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
Calendar c = Calendar.getInstance();
String issue_date=sdf.format(c.getTime());
c.setTime(new Date()); // Now use today date.
c.add(Calendar.DATE, 15); // Adding 5 days
String output = sdf.format(c.getTime());
String renual_date=sdf.format(c.getTime());
String session_user=(String)session.getAttribute("user");
if(session_user!=null)
{
String submit=null;
submit=request.getParameter("submit");
if(submit!=null)
{
	String bookid=request.getParameter("book_id");
	String userid=request.getParameter("userid");
	
	
	Connection con=null;		
	PreparedStatement pstInsertItem=null;
	ResultSet resultInsertItem=null;		
	try{						
	Class.forName("com.mysql.jdbc.Driver");
	con=DriverManager.getConnection("jdbc:mysql://localhost:3306/test","root","126459");
	String	sqlInsertItem="insert into issue_book(user_id,book_id,issue_date,renual_date) values('"+userid+"','"+bookid+"','"+issue_date+"','"+renual_date+"')";
	pstInsertItem=con.prepareStatement(sqlInsertItem);
	pstInsertItem.executeUpdate();
	out.println("Success fully added");
	}
	catch(ClassNotFoundException e){
		out.println("<b>Driver Class not found Exception: </b>"+e.getMessage());
		
	}
	catch(SQLException e){
		out.println("<b>SQL EXception:</b>"+e.getMessage());
	}
	finally{
		try{
	if(con!=null)
		con.close();
		}
		catch(SQLException e){
			out.println("<br>Connection Closing Exception: </b>"+e.getMessage());
			
		}
	}
	}
}
else
	response.sendRedirect("index.jsp");
%>

<form action="issue_book.jsp">
<p>Book Id:<input type="text" name="book_id"></p>
<p>User Id:<input type="text" name="userid"></p>

<input type="submit" value="Submit" name="submit">
</form>
    
    
  </div> <!-- /container -->
</div> <!-- /wrap -->
      
<div id="footer">
      <div class="container">
        <p class="muted credit"></p>
      </div>
</div>



</body>
</html>