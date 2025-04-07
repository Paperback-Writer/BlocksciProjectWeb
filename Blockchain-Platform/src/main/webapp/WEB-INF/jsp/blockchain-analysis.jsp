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
        
        /* 左侧 metrics 样式 */
        .metrics-list {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding-right: 10px;
        }
        
        .metric-tab {
            width: 100%;
            text-align: center;
            padding: 10px;
            margin-bottom: 10px;
            background-color: white;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-weight: bold;
            color: #495057;
            transition: all 0.3s ease;
            cursor: pointer;
            display: block;
            text-decoration: none;
        }
        
        .metric-tab:hover {
            background-color: #e9ecef;
        }
        
        .metric-tab.active {
            background-color: #e9ecef;
            border-color: #adb5bd;
        }

        /* 下拉菜单优化 */
        .custom-dropdown-width {
            width: auto;
            min-width: 200px;
            max-width: 280px;
        }

        /* 让两个下拉菜单并排 */
        .dropdown-container {
            display: flex;
            align-items: center;
            gap: 15px; /* 让两个下拉框之间有一点间距 */
        }

        /* 图片展示区域 */
        .blockchain-image-container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 500px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background: white;
        }

        .blockchain-image-container img {
            max-width: 100%;
            height: auto;
            object-fit: contain;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 class="text-center my-4">Blockchain Analysis Platform</h1>
        
        <div class="row">
            <!-- 左侧指标选择 -->
            <div class="col-md-3">
                <h5 class="text-center">Metrics</h5>
                <div class="metrics-list">
                    <c:forEach items="${metrics}" var="metric">
                        <a class="metric-tab ${selectedMetric == metric ? 'active' : ''}" 
                           href="${contextPath}/blockchain.html?cryptocurrency=${selectedCryptocurrency}&metric=${metric}&analysisType=${selectedAnalysisType}">
                            ${metric}
                        </a>
                    </c:forEach>
                </div>
            </div>

            <!-- 右侧内容区域 -->
            <div class="col-md-9">
                <form id="analysisForm" method="get" action="${contextPath}/blockchain.html">
                    <div class="dropdown-container">
                        <!-- Cryptocurrency 选择框 -->
                        <div>
                            <label for="cryptocurrency">Select Cryptocurrency:</label>
                            <select class="form-control form-control-sm custom-dropdown-width" 
                                    id="cryptocurrency" 
                                    name="cryptocurrency" 
                                    onchange="updateForm()">
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

                        <!-- Analysis Type 选择框 -->
                        <div>
                            <label for="analysisType">Analysis Type:</label>
                            <select class="form-control form-control-sm custom-dropdown-width" 
                                    id="analysisType" 
                                    name="analysisType" 
                                    onchange="updateForm()">
                                <option value="static" ${selectedAnalysisType == 'static' ? 'selected' : ''}>Static</option>
                                <option value="temporal" ${selectedAnalysisType == 'temporal' ? 'selected' : ''}>Temporal</option>
                                <option value="cluster" ${selectedAnalysisType == 'cluster' ? 'selected' : ''}>Cluster</option>
                            </select>
                        </div>
                    </div>
                </form>

                <!-- 图片展示区域 -->
                <div class="row">
                    <c:choose>
                        <c:when test="${not empty images}">
                            <c:forEach items="${images}" var="image">
                                <div class="col-md-12 d-flex justify-content-center">
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
        </div>
    </div>

    <footer class="footer">
        <div class="container-fluid">
            <p class="mb-0">&copy; 2025 Zhongxing Du. All Rights Reserved.</p>
        </div>
    </footer>

    <script>
        function updateForm() {
            const cryptocurrency = document.getElementById('cryptocurrency').value;
            const analysisType = document.getElementById('analysisType').value;
            const metric = '${selectedMetric}';
            
            window.location.href = '${contextPath}/blockchain.html?cryptocurrency=' + 
                cryptocurrency + '&metric=' + encodeURIComponent(metric) + 
                '&analysisType=' + analysisType;
        }

        document.addEventListener('DOMContentLoaded', function() {
            const metricTabs = document.querySelectorAll('.metric-tab');

            metricTabs.forEach(tab => {
                tab.addEventListener('click', function(e) {
                    metricTabs.forEach(t => t.classList.remove('active'));
                    this.classList.add('active');
                });
            });
        });
    </script>
</body>
</html>