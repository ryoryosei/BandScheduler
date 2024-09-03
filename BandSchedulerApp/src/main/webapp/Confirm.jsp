<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="control.ConfirmServlet" %>
<%@page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
<title>確認する月のスケジュール</title>
</head>
<body>
    <%@include file="header.jsp"%>
    <div class="container mt-5">
        
        <div class="mt-4">
            <% ArrayList<ArrayList<ArrayList<String>>> tableList = (ArrayList<ArrayList<ArrayList<String>>>)request.getAttribute("tableList"); %>
            <% String month = (String)request.getAttribute("month"); %>
            <h2 class="text-center"><%= month %>月</h2>
            <% ArrayList<ArrayList<String>> enable = new ArrayList<>(); %>
            <% for (int names = 0; names < tableList.size(); names++) { %>
                <div class="schedule mb-4">
                    <h3 class="text-center"><%= tableList.get(names).get(0).get(0) %>のスケジュール</h3>
                    <table class="table table-bordered table-striped">
                        <thead class="thead-dark">
                            <tr>
                                <th scope="col">日にち</th>
                                <th scope="col">1限</th>
                                <th scope="col">2限</th>
                                <th scope="col">3限</th>
                                <th scope="col">4限</th>
                                <th scope="col">5限</th>
                                <th scope="col">18時～</th>
                                <th scope="col">19時～</th>
                                <th scope="col">20時～</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (int i = 0; i < tableList.get(names).size(); i++) { %>
                                <tr>
                                    <td><%= tableList.get(names).get(i).get(1) %>日</td>
                                    <td><%= tableList.get(names).get(i).get(2) %></td>
                                    <td><%= tableList.get(names).get(i).get(3) %></td>
                                    <td><%= tableList.get(names).get(i).get(4) %></td>
                                    <td><%= tableList.get(names).get(i).get(5) %></td>
                                    <td><%= tableList.get(names).get(i).get(6) %></td>
                                    <td><%= tableList.get(names).get(i).get(7) %></td>
                                    <td><%= tableList.get(names).get(i).get(8) %></td>
                                    <td><%= tableList.get(names).get(i).get(9) %></td>
                                </tr>
                                <% for (int j = 2; j < 10; j++) { %>
                                    <% if (tableList.get(names).get(i).get(j).equals("〇")) { %>
                                        <% ArrayList<String> enableData = new ArrayList<>(); %>
                                        <% enableData.add(tableList.get(names).get(i).get(1)); %>
                                        <% enableData.add(Integer.toString(j - 1)); %>
                                        <% enable.add(enableData); %>
                                    <% } %>
                                <% } %>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            <% } %>
            <br>
            <hr>
            <hr>
            <h2 class="text-center"><%= tableList.size() %>人全員が練習可能な日時</h2>
            <table class="table table-bordered table-striped mt-4">
                <thead class="thead-dark">
                    <tr>
                        <th scope="col">日にち</th>
                        <th scope="col">1限</th>
                        <th scope="col">2限</th>
                        <th scope="col">3限</th>
                        <th scope="col">4限</th>
                        <th scope="col">5限</th>
                        <th scope="col">18時～</th>
                        <th scope="col">19時～</th>
                        <th scope="col">20時～</th>
                    </tr>
                </thead>
                <tbody>
                    <% int count = 0; %>
                    <% int Icounter = 0; %>
                    <% ArrayList<Integer> printf = new ArrayList<>(); %>
                    
                    <% //全員が〇な日（i日）を探す%>
                    <% for (int i = 0; i < enable.size(); i++) { %>
                        <% count = 0; %>
                        <% for (int j = i + 1; j < enable.size(); j++) { %>
                            <% if (enable.get(i).equals(enable.get(j))) { %>
                                <% count++; %>
                                <% if (count == tableList.size() - 1) { %>
                                	<% printf.add(i); %>
                                <% } %>
                            <% } %>
                        <% } %>
                    <% } %>
                    
                    
                    
                    <% //同じ日があったらIcounterを増やして、その数に応じて条件分岐し、表の表示数を分ける %>
                    <% for (int I = 0; I < printf.size(); I++) { %>
                    	<% Icounter = 0; %>
                    	
                    	<% for (int nextI = I+1; nextI < printf.size(); nextI++) { %>
                    		<% if (enable.get(printf.get(I)).get(0).equals(enable.get(printf.get(nextI)).get(0))) { %>
                    			<% Icounter++; %>
                    		<% } %>
                        <% } %>
                        
                        <% if (Icounter == 0) { %>
		                	<tr>
		                    	<td><%= enable.get(printf.get(I)).get(0) %>日</td>
		                        <% for (int q = 1; q <= 8; q++) { %>
		                        	<% if (enable.get(printf.get(I)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else { %>
		                            	<td>　</td>
		                            <% } %>
		                        <% } %>
		                    </tr>
		                <% } else if (Icounter == 1) { %>
		                	<tr>
		                    	<td><%= enable.get(printf.get(I)).get(0) %>日</td>
		                        <% for (int q = 1; q <= 8; q++) { %>
		                        	<% if (enable.get(printf.get(I)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf.get(I + 1)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else { %>
		                            	<td>　</td>
		                            <% } %>
		                        <% } %>
		                    </tr>
		                <% } else if (Icounter == 2) { %>
		                	<tr>
		                    	<td><%= enable.get(printf.get(I)).get(0) %>日</td>
		                        <% for (int q = 1; q <= 8; q++) { %>
		                        	<% if (enable.get(printf.get(I)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf.get(I + 1)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf.get(I + 2)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else { %>
		                            	<td>　</td>
		                            <% } %>
		                        <% } %>
		                    </tr>
                        <% } else if (Icounter == 3) { %>
		                	<tr>
		                    	<td><%= enable.get(printf.get(I)).get(0) %>日</td>
		                        <% for (int q = 1; q <= 8; q++) { %>
		                        	<% if (enable.get(printf.get(I)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf.get(I + 1)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf.get(I + 2)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf.get(I + 3)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else { %>
		                            	<td>　</td>
		                            <% } %>
		                        <% } %>
		                    </tr>
		                <% } else if (Icounter == 4) { %>
		                	<tr>
		                    	<td><%= enable.get(printf.get(I)).get(0) %>日</td>
		                        <% for (int q = 1; q <= 8; q++) { %>
		                        	<% if (enable.get(printf.get(I)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf.get(I + 1)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf.get(I + 2)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf.get(I + 3)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf.get(I + 4)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else { %>
		                            	<td>　</td>
		                            <% } %>
		                        <% } %>
		                    </tr>
		                <% } else if (Icounter == 5) { %>
		                	<tr>
		                    	<td><%= enable.get(printf.get(I)).get(0) %>日</td>
		                        <% for (int q = 1; q <= 8; q++) { %>
		                        	<% if (enable.get(printf.get(I)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf.get(I + 1)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf.get(I + 2)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf.get(I + 3)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf.get(I + 4)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf.get(I + 5)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else { %>
		                            	<td>　</td>
		                            <% } %>
		                        <% } %>
		                    </tr>
		                <% } else if (Icounter == 6) { %>
		                	<tr>
		                    	<td><%= enable.get(printf.get(I)).get(0) %>日</td>
		                        <% for (int q = 1; q <= 8; q++) { %>
		                        	<% if (enable.get(printf.get(I)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf.get(I + 1)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf.get(I + 2)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf.get(I + 3)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf.get(I + 4)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf.get(I + 5)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf.get(I + 6)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else { %>
		                            	<td>　</td>
		                            <% } %>
		                        <% } %>
		                    </tr>
		                <% } else if (Icounter == 7) { %>
		                	<tr>
		                    	<td><%= enable.get(printf.get(I)).get(0) %>日</td>
		                        <% for (int q = 1; q <= 8; q++) { %>
		                        	<% if (enable.get(printf.get(I)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf.get(I + 1)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf.get(I + 2)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf.get(I + 3)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf.get(I + 4)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf.get(I + 5)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf.get(I + 6)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf.get(I + 7)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else { %>
		                            	<td>　</td>
		                            <% } %>
		                        <% } %>
		                    </tr>
		                <% } else if (Icounter == 8) { %>
		                	<tr>
		                    	<td><%= enable.get(printf.get(I)).get(0) %>日</td>
		                        <% for (int q = 1; q <= 8; q++) { %>
		                        	<% if (enable.get(printf.get(I)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf.get(I + 1)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf.get(I + 2)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf.get(I + 3)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf.get(I + 4)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf.get(I + 5)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf.get(I + 6)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf.get(I + 7)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf.get(I + 8)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else { %>
		                            	<td>　</td>
		                            <% } %>
		                        <% } %>
		                    </tr>
		                <% } else { %>
		                <% } %>
		                
		                <% I = I + Icounter; %>
		            <% } %>
                </tbody>
            </table>
            
            
            <hr>
            <hr>
            
            <% if (tableList.size() > 2){ %>
            <h2 class="text-center"><%= tableList.size() -1 %>人が練習可能な日時</h2>
            <table class="table table-bordered table-striped mt-4">
                <thead class="thead-dark">
                    <tr>
                        <th scope="col">日にち</th>
                        <th scope="col">1限</th>
                        <th scope="col">2限</th>
                        <th scope="col">3限</th>
                        <th scope="col">4限</th>
                        <th scope="col">5限</th>
                        <th scope="col">18時～</th>
                        <th scope="col">19時～</th>
                        <th scope="col">20時～</th>
                    </tr>
                </thead>
                <tbody>
                    <% count = 0; %>
                    <% Icounter = 0; %>
                    <% ArrayList<Integer> printf2 = new ArrayList<>(); %>
                    
                    <% //全員が〇な日（i日）を探す%>
                    <% for (int i = 0; i < enable.size(); i++) { %>
                        <% count = 0; %>
                        <% for (int j = i + 1; j < enable.size(); j++) { %>
                            <% if (enable.get(i).equals(enable.get(j))) { %>
                                <% count++; %>
                                <% if (count >= tableList.size() - 2) { %>
                                	<% printf2.add(i); %>
                                <% } %>
                            <% } %>
                        <% } %>
                    <% } %>
                    
                    
                    <% //同じ日があったらIcounterを増やして、その数に応じて条件分岐し、表の表示数を分ける %>
                    <% for (int I = 0; I < printf2.size(); I++) { %>
                    	<% Icounter = 0; %>
                    	
                    	<% for (int nextI = I+1; nextI < printf2.size(); nextI++) { %>
                    		<% if (enable.get(printf2.get(I)).get(0).equals(enable.get(printf2.get(nextI)).get(0))) { %>
                    			<% Icounter++; %>
                    		<% } %>
                        <% } %>
                        
                        <% if (Icounter == 0) { %>
		                	<tr>
		                    	<td><%= enable.get(printf2.get(I)).get(0) %>日</td>
		                        <% for (int q = 1; q <= 8; q++) { %>
		                        	<% if (enable.get(printf2.get(I)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else { %>
		                            	<td>　</td>
		                            <% } %>
		                        <% } %>
		                    </tr>
		                <% } else if (Icounter == 1) { %>
		                	<tr>
		                    	<td><%= enable.get(printf2.get(I)).get(0) %>日</td>
		                        <% for (int q = 1; q <= 8; q++) { %>
		                        	<% if (enable.get(printf2.get(I)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf2.get(I + 1)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else { %>
		                            	<td>　</td>
		                            <% } %>
		                        <% } %>
		                    </tr>
		                <% } else if (Icounter == 2) { %>
		                	<tr>
		                    	<td><%= enable.get(printf2.get(I)).get(0) %>日</td>
		                        <% for (int q = 1; q <= 8; q++) { %>
		                        	<% if (enable.get(printf2.get(I)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf2.get(I + 1)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf2.get(I + 2)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else { %>
		                            	<td>　</td>
		                            <% } %>
		                        <% } %>
		                    </tr>
                        <% } else if (Icounter == 3) { %>
		                	<tr>
		                    	<td><%= enable.get(printf2.get(I)).get(0) %>日</td>
		                        <% for (int q = 1; q <= 8; q++) { %>
		                        	<% if (enable.get(printf2.get(I)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf2.get(I + 1)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf2.get(I + 2)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf2.get(I + 3)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else { %>
		                            	<td>　</td>
		                            <% } %>
		                        <% } %>
		                    </tr>
		                <% } else if (Icounter == 4) { %>
		                	<tr>
		                    	<td><%= enable.get(printf2.get(I)).get(0) %>日</td>
		                        <% for (int q = 1; q <= 8; q++) { %>
		                        	<% if (enable.get(printf2.get(I)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf2.get(I + 1)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf2.get(I + 2)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf2.get(I + 3)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf2.get(I + 4)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else { %>
		                            	<td>　</td>
		                            <% } %>
		                        <% } %>
		                    </tr>
		                <% } else if (Icounter == 5) { %>
		                	<tr>
		                    	<td><%= enable.get(printf2.get(I)).get(0) %>日</td>
		                        <% for (int q = 1; q <= 8; q++) { %>
		                        	<% if (enable.get(printf2.get(I)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf2.get(I + 1)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf2.get(I + 2)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf2.get(I + 3)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf2.get(I + 4)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf2.get(I + 5)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else { %>
		                            	<td>　</td>
		                            <% } %>
		                        <% } %>
		                    </tr>
		                <% } else if (Icounter == 6) { %>
		                	<tr>
		                    	<td><%= enable.get(printf2.get(I)).get(0) %>日</td>
		                        <% for (int q = 1; q <= 8; q++) { %>
		                        	<% if (enable.get(printf2.get(I)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf2.get(I + 1)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf2.get(I + 2)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf2.get(I + 3)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf2.get(I + 4)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf2.get(I + 5)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf2.get(I + 6)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else { %>
		                            	<td>　</td>
		                            <% } %>
		                        <% } %>
		                    </tr>
		                <% } else if (Icounter == 7) { %>
		                	<tr>
		                    	<td><%= enable.get(printf2.get(I)).get(0) %>日</td>
		                        <% for (int q = 1; q <= 8; q++) { %>
		                        	<% if (enable.get(printf2.get(I)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf2.get(I + 1)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf2.get(I + 2)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf2.get(I + 3)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf2.get(I + 4)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf2.get(I + 5)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf2.get(I + 6)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf2.get(I + 7)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else { %>
		                            	<td>　</td>
		                            <% } %>
		                        <% } %>
		                    </tr>
		                <% } else if (Icounter == 8) { %>
		                	<tr>
		                    	<td><%= enable.get(printf2.get(I)).get(0) %>日</td>
		                        <% for (int q = 1; q <= 8; q++) { %>
		                        	<% if (enable.get(printf2.get(I)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf2.get(I + 1)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf2.get(I + 2)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf2.get(I + 3)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf2.get(I + 4)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf2.get(I + 5)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf2.get(I + 6)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf2.get(I + 7)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else if (enable.get(printf2.get(I + 8)).get(1).equals(Integer.toString(q))) { %>
		                            	<td>〇</td>
		                            <% } else { %>
		                            	<td>　</td>
		                            <% } %>
		                        <% } %>
		                    </tr>
		                <% } else { %>
		                <% } %>
		                
		                <% I = I + Icounter; %>
		            <% } %>     
                </tbody>
            </table>
            <% } %>
        </div>
    </div>
</body>
</html>
