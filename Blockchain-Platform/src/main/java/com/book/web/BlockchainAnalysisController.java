package com.book.web;

import com.book.service.BlockchainDataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;
import java.util.Map;

@Controller
public class BlockchainAnalysisController {
    
    private final BlockchainDataService blockchainDataService;
    
    @Autowired
    public BlockchainAnalysisController(BlockchainDataService blockchainDataService) {
        this.blockchainDataService = blockchainDataService;
    }
    
    @RequestMapping("/blockchain.html")
    public ModelAndView showBlockchainAnalysis(
            @RequestParam(value = "cryptocurrency", required = false, defaultValue = "bitcoin") String cryptocurrency,
            @RequestParam(value = "metric", required = false, defaultValue = "Gini Index") String metric,
            @RequestParam(value = "analysisType", required = false, defaultValue = "static") String analysisType) {
        
        ModelAndView modelAndView = new ModelAndView("blockchain-analysis");
        
        // 可用的加密货币列表
        String[] cryptocurrencies = {
            "bitcoin", "dogecoin", "bitcash", 
            "monacoin", "feathercoin", "litecoin"
        };
        
        // 可用的指标列表
        String[] metrics = {
            "Gini Index", "Micro Velocity", "Transaction Throughput", 
            "Block Size", "Trade-offs Analysis", 
            "Correlation between Fee and Amount", "Fund flow"
        };

        // 可用的分析类型
        String[] analysisTypes = {"static", "temporal", "cluster"};
        
        // 设置模型属性
        modelAndView.addObject("cryptocurrencies", cryptocurrencies);
        modelAndView.addObject("metrics", metrics);
        modelAndView.addObject("analysisTypes", analysisTypes);
        modelAndView.addObject("selectedCryptocurrency", cryptocurrency);
        modelAndView.addObject("selectedMetric", metric);
        modelAndView.addObject("selectedAnalysisType", analysisType);
        
        // 从数据库获取图表数据
        List<Object> chartData = blockchainDataService.getChartData(
            cryptocurrency, metric, analysisType
        );
        modelAndView.addObject("chartData", chartData);
        
        return modelAndView;
    }

    // 可选：添加数据导入的方法
    @RequestMapping("/import-blockchain-data")
    public String importBlockchainData() {
        // 这里可以实现数据导入逻辑
        // 例如从CSV文件或其他数据源批量导入数据到数据库
        return "import-success";
    }
}