<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>予定送信</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link href="css/scheduleForm.css" rel="stylesheet" type="text/css">

    <script>
        function updateHiddenValues() {
            const checkboxes = document.querySelectorAll('input[type="checkbox"]');
            checkboxes.forEach(checkbox => {
                const hiddenInput = checkbox.previousElementSibling;
                if (checkbox.checked) {
                    hiddenInput.remove();
                } else {
                    checkbox.remove();
                }
            });
        }
    </script>
</head>
<body>
    <%@include file="header.jsp"%><br>
    
    <%  String month = (String) request.getAttribute("month");
        int dayStart = Integer.parseInt((String) request.getAttribute("dayStart"));
        int dayEnd = Integer.parseInt((String) request.getAttribute("dayEnd"));
    %>
    
    <div class="container mt-5">
        <h2 class="text-center"><%=month %>月の練習可能な時間を送信</h2>
        
        <form action="form-servlet" method="post" onsubmit="updateHiddenValues()" class="mt-4">
            <div class="form-group">
                <label for="name">名前：</label>
                <input type="text" id="name" name="name" class="form-control" required>
            </div>
            <hr>

            <div class="table-responsive">
                <table class="table table-bordered text-center">
                    <thead class="thead-dark">
                        <tr>
                            <th scope="col">日にち</th>
                            <th scope="col">１限</th>
                            <th scope="col">２限</th>
                            <th scope="col">３限</th>
                            <th scope="col">４限</th>
                            <th scope="col">５限</th>
                            <th scope="col">18:00～</th>
                            <th scope="col">19:00～</th>
                            <th scope="col">20:00～</th>
                            <th scope="col">全選択</th>
                        </tr>
                    </thead>
                    <tbody>
                        <input type="hidden" name="month" value="<%=month %>">
                        <% for (int i = dayStart; i <= dayEnd; i++) { %>
                        <input type="hidden" name="day" value="<%=i %>">
                            <tr>
                                <th scope="row"><%=i %>日</th>
                                <td>
                                    <input type="hidden" class="checks" name="first" value="　">
                                    <input type="checkbox" name="first" value="〇" class="form-check-input">
                                </td>
                                <td>
                                    <input type="hidden" class="checks" name="second" value="　">
                                    <input type="checkbox" name="second" value="〇" class="form-check-input">
                                </td>
                                <td>
                                    <input type="hidden" class="checks" name="third" value="　">
                                    <input type="checkbox" name="third" value="〇" class="form-check-input">
                                </td>
                                <td>
                                    <input type="hidden" class="checks" name="forth" value="　">
                                    <input type="checkbox" name="forth" value="〇" class="form-check-input">
                                </td>
                                <td>
                                    <input type="hidden" class="checks" name="fifth" value="　">
                                    <input type="checkbox" name="fifth" value="〇" class="form-check-input">
                                </td>
                                <td>
                                    <input type="hidden" class="checks" name="eight" value="　">
                                    <input type="checkbox" name="eight" value="〇" class="form-check-input">
                                </td>
                                <td>
                                    <input type="hidden" class="checks" name="nine" value="　">
                                    <input type="checkbox" name="nine" value="〇" class="form-check-input">
                                </td>
                                <td>
                                    <input type="hidden" class="checks" name="last" value="　">
                                    <input type="checkbox" name="last" value="〇" class="form-check-input">
                                </td>
                                <td>
                                	<input type="checkbox" id="checksAll" class="form-check-input">
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
                </div>
            </div>

            <div class="text-center mt-4">
                <input type="submit" value="送信" class="btn btn-primary btn-lg">
            </div>
        </form>
    </div>
    
    <script type="text/javascript">
        document.addEventListener('DOMContentLoaded', function () {
            const checkAllBoxes = document.querySelectorAll('.checkall');
            const checkboxes = document.querySelectorAll('.checks');

            checkAllBoxes.forEach(checkall => {
                checkall.addEventListener('click', () => {
                    checkboxes.forEach(checkbox => {
                        checkbox.checked = checkall.checked;
                    });
                });
            });

            checkboxes.forEach(checkbox => {
                checkbox.addEventListener('click', () => {
                    checkAllBoxes.forEach(checkall => {
                        checkall.checked = checkboxes.length === document.querySelectorAll('.checks:checked').length;
                    });
                });
            });
        });
    </script>
</body>
</html>
