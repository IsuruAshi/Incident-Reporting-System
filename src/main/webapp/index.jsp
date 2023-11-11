<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <title>JSP - Hello World</title>
    <title>Title</title>
</head>
<body>
<header class="p-2 text-center">
    <h1 class="mb-0"> Incident Report Collection</h1>

</header>
<main class="container-fluid">
    <div class="row">
        <div class="col-xl-4">
            <h2>Incident Details</h2>
            <form action="index.jsp" method="POST" enctype="multipart/form-data">
                <div class="mb-3">
                    <label for="incident" class="form-label">Incident</label>
                    <input name="incident" minlength="4" type="text" class="form-control" id="incident" >

                </div>
                <div class="mb-3">
                    <label for="date" class="form-label">Date of Incident</label>
                    <input name="date" type="date" class="form-control" id="date">
                </div>
                <div class="mb-3">
                    <label for="description" class="form-label">Description</label>
                    <input name="description" required minlength="10" type="text" class="form-control" id="description" >
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
                    <label for="txt-image" class="form-label">Incident Image</label>
                    <input name="picture" accept="image/*" class="form-control" type="file" id="txt-image">
                </div>
                <div class="mb-3">
                    <button class="btn btn-success">SAVE</button>
                    <button type="reset" class="btn btn-warning">CLEAR</button>
                </div>
            </form>
        </div>
        <div class="col-xl-8">
            <table class="table">
                <thead>
                <tr>
                    <th scope="col">ID</th>
                    <th scope="col">DATE</th>
                    <th scope="col">INCIDENT</th>
                    <th scope="col">DESCRIPTION</th>
                    <th scope="col">LOCATION</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <th scope="row">1</th>
                    <td>Mark</td>
                    <td>Otto</td>
                    <td>@mdo</td>
                    <td>@mdo</td>
                </tr>
                <tr>
                    <th scope="row">2</th>
                    <td>Jacob</td>
                    <td>Thornton</td>
                    <td>Thornton</td>
                    <td>@fat</td>
                </tr>
                <tr>
                    <th scope="row">3</th>
                    <td colspan="2">Larry the Bird</td>
                    <td>@twitter</td>
                    <td>@twitter</td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div class="row">

    </div>
    </main>
</body>
</html>