<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% application.getNamedDispatcher("IncidentServlet").include(request, response); %>
<!DOCTYPE html>
<html lang="en" data-bs-theme="${mode}">
<head>
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;300;400;500;700;900&display=swap"
          rel="stylesheet">
    <link rel="stylesheet" href="style.css">
    <title>Welcome to IRS</title>

</head>
<body>
<%@include file="WEB-INF/header.jsp"%>
<main class="container-fluid">
    <div class="row">
        <div class="col-xl-4">
            <h2>Incident Details</h2>
            <form  action="incidents" method="POST" autocomplete="off" enctype="multipart/form-data">
                <div class="mb-3">
                    <label for="incident" class="form-label">Incident</label>
                    <input required name="incident" minlength="4" type="text" class="form-control" id="incident" >

                </div>
                <div class="mb-3">
                    <label for="date" class="form-label">Date of Incident</label>
                    <input required name="date" type="date" class="form-control" id="date">
                </div>
                <div class="mb-3">
                    <label  class="form-label">Description</label>
                    <div class="form-floating">
                        <textarea name="description" required minlength="10" class="form-control" placeholder="Leave a comment here" id="description" style="height: 100px"></textarea>
                        <label for="description">Description</label>
                    </div>
                </div>

                <div class="mb-3">
                    <label for="location" class="form-label">Location</label>
                    <input name="location" required minlength="3" type="text" class="form-control" id="location" >
                </div>
                <div class="mb-3">
                    <label for="reporting-person" class="form-label">Reporting person</label>
                    <input name="person" required pattern="^[A-Za-z ]+$"  type="text" class="form-control" id="reporting-person" >
                </div>
                <div class="mb-3">
                    <label for="txt-picture" class="form-label">Incident Image</label>
                    <input name="picture" accept="image/*" class="form-control" type="file" id="txt-picture">
                </div>
                <div class="mb-3">
                    <button class="btn btn-success">SAVE</button>
                    <button type="reset" class="btn btn-warning">CLEAR</button>
                </div>
            </form>
        </div>
    <div class="row">
        <div class="col-xl">
            <table class="mt-2 table table-bordered table-hover">
                <thead>
                <tr>
                    <th class="text-center" scope="col">ID</th>
                    <th class="text-center" scope="col">DATE</th>
                    <th class="text-center" scope="col">INCIDENT</th>
                    <th class="text-center" scope="col">DESCRIPTION</th>
                    <th class="text-center" scope="col">LOCATION</th>
                    <th class="text-center" scope="col">IMAGE</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="incident" items="${incidentList}">
                    <tr>
                        <td class="text-center">${incident.id}</td>
                        <td>${incident.date}</td>
                        <td>${incident.incident}</td>
                        <td>${incident.description}</td>
                        <td>${incident.location}</td>
                        <td class="text-center">
                            <img class="incident-picture img-thumbnail" src="${empty incident.pictureUrl? 'img/no-pic.png':incident.pictureUrl}">
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
                <c:if test="${empty incidentList}">
                    <tfoot>
                    <tr>
                        <td colspan="6" class="text-center">
                            There are no incident records to display
                        </td>
                    </tr>
                    </tfoot>
                </c:if>
            </table>
        </div>
    </div>
    </div>
    </main>
<%@include file="WEB-INF/footer.jsp"%>
</body>
</html>