<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>图片展示</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <script src="js/jquery-3.2.1.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <style>
        .image-container {
            margin-bottom: 20px;
        }
        .image-container img {
            width: 100%;
            height: auto;
            border: 1px solid #ddd;
            border-radius: 4px;
            padding: 5px;
        }
        .image-container .caption {
            margin-top: 10px;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 class="text-center">图片展示</h1>
        
        <div class="row">
            <div class="col-md-12">
                <form class="form-inline" method="get" action="gallery.html">
                    <div class="form-group">
                        <label for="category">选择类别：</label>
                        <select class="form-control" id="category" name="category" onchange="this.form.submit()">
                            <option value="">全部</option>
                            <c:forEach items="${categories}" var="category">
                                <option value="${category.folderName}" ${selectedCategory == category.folderName ? 'selected' : ''}>${category.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                </form>
            </div>
        </div>
        
        <div class="row">
            <c:forEach items="${images}" var="image">
                <div class="col-md-4 image-container">
                    <img src="${image.path}" alt="${image.name}">
                    <div class="caption">
                        <h4>${image.name}</h4>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</body>
</html>