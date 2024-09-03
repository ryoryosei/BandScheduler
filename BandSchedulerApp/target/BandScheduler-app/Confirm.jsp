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
            <hr>
            <h2 class="text-center">みんなが共通して空いてる時間</h2>
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
                    <% for (int i = 0; i < enable.size(); i++) { %>
                        <% count = 0; %>
                        <% for (int j = i + 1; j < enable.size(); j++) { %>
                            <% if (enable.get(i).equals(enable.get(j))) { %>
                                <% count++; %>
                                <% if (count == tableList.size() - 1) { %>
                                    <tr>
                                        <td><%= enable.get(i).get(0) %>日</td>
                                        <% for (int q = 1; q <= 8; q++) { %>
                                            <% if (enable.get(i).get(1).equals(Integer.toString(q))) { %>
                                                <td>〇</td>
                                            <% } else { %>
                                                <td>　</td>
                                            <% } %>
                                        <% } %>
                                    </tr>
                                <% } %>
                            <% } %>
                        <% } %>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
