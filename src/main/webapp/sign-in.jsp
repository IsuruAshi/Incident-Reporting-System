<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="false" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title> 🔆 Sign In </title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    <style>
        .toast.show {
            animation-name: hide;
            animation-duration: 3s;
            animation-delay: 1s;
            animation-fill-mode: forwards;
        }

        @keyframes hide {
            from {
                opacity: 1;
            }

            to {
                opacity: 0;
                display: none;
            }
        }
    </style>
</head>
<body class="vh-100 d-flex align-items-center justify-content-center">
<form action="sign-in" method="POST" class="p-2 text-center border px-4 rounded">
    <h1 class="pt-2">Incident Reporting System</h1>
    <div class="mb-3">
        <label for="txt-email" class="form-label">Email address</label>
        <input name="email" required type="email"
               class="form-control text-center ${denied ? 'is-invalid': ''}" id="txt-email" placeholder="Enter your email here">
    </div>
    <div class="mb-3">
        <label for="txt-password" class="form-label">Password</label>
        <input name="password" required minlength="4" maxlength="10" type="password"
               class="form-control text-center ${denied ? 'is-invalid': ''}" id="txt-password" placeholder="Enter your password here">
    </div>
    <div class="mb-3 text-center d-flex justify-content-center">
        <label class="form-check-label px-2" for="switch">Dark</label>
        <div class="form-check form-switch">
            <input name="mode" value="light" class="form-check-input" type="checkbox" role="switch" id="switch" checked>
            <label class="form-check-label" for="switch">Light</label>
        </div>
    </div>
    <div class="mb-3">
        <div class="form-check d-flex justify-content-center gap-2">
            <input name="remember-me" class="form-check-input" type="checkbox" value="" id="ck-checked">
            <label class="form-check-label" for="ck-checked">
                Remember Me
            </label>
        </div>
    </div>
    <div>
        <button class="btn btn-primary">Sign In</button>
        <p class="pt-3 m-0">New to IRS?
            <a href="sign-up.jsp">Sign Up</a>
        </p>
    </div>
</form>
<c:if test="${error or denied or param.get('created')}">
    <div class="${(error or denied) ? 'text-bg-danger' : 'text-bg-success'} position-fixed toast show align-items-center border-0 top-0 start-50 translate-middle-x mt-3" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="d-flex">
            <div class="toast-body">
                <c:choose>
                    <c:when test="${error}">
                        Something went wrong, please try again.
                    </c:when>
                    <c:when test="${denied}">
                        Invalid login credentials, please try again.
                    </c:when>
                    <c:when test="${param.get('created')}">
                        Your account has been created successfully
                    </c:when>
                </c:choose>
            </div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
    </div>
</c:if>
</body>
</html>