package com.book.web;

import com.book.domain.Image;
import com.book.service.BlockchainService;
import com.book.service.RemoteDataService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;
import java.util.stream.Collectors;

@Controller  // 确保有这个注解
public class BlockchainAnalysisController {
    
    private final BlockchainService blockchainService;
    private final RemoteDataService remoteDataService;
    
    @Autowired
    public BlockchainAnalysisController(
        BlockchainService blockchainService, 
        RemoteDataService remoteDataService
    ) {
        this.blockchainService = blockchainService;
        this.remoteDataService = remoteDataService;
    }
    
    @RequestMapping("/blockchain.html")
    public ModelAndView showBlockchainAnalysis(
            @RequestParam(value = "cryptocurrency", required = false, defaultValue = "bitcoin") String cryptocurrency,
            @RequestParam(value = "metric", required = false, defaultValue = "A") String metric) {
        
        ModelAndView modelAndView = new ModelAndView("blockchain-analysis");
        
        // 可用的加密货币列表
        String[] cryptocurrencies = {
            "bitcoin", "dogecoin", "bitcash", 
            "monacoin", "feathercoin", "litecoin"
        };
        
        // 可用的指标列表
        String[] metrics = {"A", "B", "C", "D", "E", "F", "G"};
        
        // 设置模型属性
        modelAndView.addObject("cryptocurrencies", cryptocurrencies);
        modelAndView.addObject("metrics", metrics);
        modelAndView.addObject("selectedCryptocurrency", cryptocurrency);
        modelAndView.addObject("selectedMetric", metric);
        
        // 获取图片
        List<Image> images = blockchainService.getBlockchainImages(cryptocurrency, metric);
        modelAndView.addObject("images", images);
        
        return modelAndView;
    }
}