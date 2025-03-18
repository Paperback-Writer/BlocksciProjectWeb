<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
    <title>Blockchain Analysis</title>
    <link rel="stylesheet" href="${contextPath}/static/css/bootstrap.min.css">
    <script src="${contextPath}/static/js/jquery-3.2.1.js"></script>
    <script src="${contextPath}/static/js/bootstrap.min.js"></script>
    <style>
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            background-image: url('${contextPath}/static/images/background.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
        }
        .container {
            background-color: rgba(255, 255, 255, 0.8);
            padding: 20px;
            border-radius: 10px;
            margin-top: 20px;
            flex: 1;
        }
        .images-row {
            display: flex;
            justify-content: center;
            align-items: stretch;
            margin-top: 50px; /* 调整垂直位置 */
        }
        .blockchain-image-container {
            margin-bottom: 20px;
            padding: 0;
            border: 1px solid #ddd;
            border-radius: 5px;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 500px; /* 固定高度 */
            width: 100%;
        }

        .blockchain-image-container img {
            width: 100%; /* 改为100% */
            height: auto; /* 保持原始比例 */
            transform: scale(2); /* 放大两倍 */
            object-fit: contain; /* 保持完整图片 */
            object-position: center; /* 居中 */
}
        .nav-tabs .nav-link {
            background-color: #f8f9fa;
            color: #495057;
            transition: all 0.3s ease;
        }
        .nav-tabs .nav-link.active {
            background-color: #e9ecef;
            color: #212529;
            font-weight: bold;
            border-color: #dee2e6 #dee2e6 #e9ecef;
        }
        .nav-tabs .nav-link:hover {
            background-color: #e9ecef;
        }
        .footer {
            background-color: rgba(0, 0, 0, 0.7);
            color: white;
            padding: 15px 0;
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 class="text-center my-4">Blockchain Analysis Platform</h1>
        
        <div class="row">
            <div class="col-md-12">
                <form id="analysisForm" method="get" action="${contextPath}/blockchain.html">
                    <div class="form-row">
                        <div class="col-md-6">
                            <label for="cryptocurrency">Select Cryptocurrency:</label>
                            <select class="form-control" id="cryptocurrency" name="cryptocurrency" onchange="this.form.submit()">
                                <c:forEach items="${cryptocurrencies}" var="crypto">
                                    <option value="${crypto}" ${selectedCryptocurrency == crypto ? 'selected' : ''}>
                                        <c:choose>
                                            <c:when test="${crypto == 'bitcoin'}">Bitcoin</c:when>
                                            <c:when test="${crypto == 'dogecoin'}">Dogecoin</c:when>
                                            <c:when test="${crypto == 'bitcash'}">Bitcoin Cash</c:when>
                                            <c:when test="${crypto == 'monacoin'}">Monacoin</c:when>
                                            <c:when test="${crypto == 'feathercoin'}">Feathercoin</c:when>
                                            <c:when test="${crypto == 'litecoin'}">Litecoin</c:when>
                                        </c:choose>
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        
                        <div class="col-md-6">
                            <label>Select Metric:</label>
                            <ul class="nav nav-tabs" id="metricTabs">
                                <c:forEach items="${metrics}" var="metric">
                                    <li class="nav-item">
                                        <a class="nav-link ${selectedMetric == metric ? 'active' : ''}" 
                                           data-metric="${metric}"
                                           href="${contextPath}/blockchain.html?cryptocurrency=${selectedCryptocurrency}&metric=${metric}">
                                            ${metric}
                                        </a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <div class="row images-row">
            <c:choose>
                <c:when test="${not empty images}">
                    <c:forEach items="${images}" var="image">
                        <div class="col-md-4 d-flex justify-content-center">
                            <div class="blockchain-image-container">
                                <img src="${contextPath}${image.path}" alt="${image.name}">
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="col-12">
                        <p class="alert alert-info text-center">
                            No analysis images available
                        </p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <footer class="footer">
        <div class="container-fluid">
            <p class="mb-0">&copy; 2025 Zhongxing Du. All Rights Reserved.</p>
        </div>
    </footer>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const metricTabs = document.getElementById('metricTabs');
            const currentMetric = '${selectedMetric}';

            metricTabs.addEventListener('click', function(e) {
                const tabs = metricTabs.querySelectorAll('.nav-link');
                tabs.forEach(tab => tab.classList.remove('active'));

                if (e.target.classList.contains('nav-link')) {
                    e.target.classList.add('active');
                }
            });
        });
    </script>
</body>
</html>