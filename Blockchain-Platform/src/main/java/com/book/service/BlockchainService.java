package com.book.service;

import com.book.domain.Image;
import org.springframework.stereotype.Service;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

@Service
public class BlockchainService {
    
    private static final String PROJECT_BASE_PATH = System.getProperty("user.dir");
    private static final String IMAGE_BASE_PATH = PROJECT_BASE_PATH + "/src/main/webapp/static/blockchain-images/";
    
    public List<Image> getBlockchainImages(String cryptocurrency, String metric) {
        List<Image> images = new ArrayList<>();
        
        System.out.println("------- 区块链图片获取调试信息 -------");
        System.out.println("项目根目录: " + PROJECT_BASE_PATH);
        System.out.println("图片基础路径: " + IMAGE_BASE_PATH);
        System.out.println("当前加密货币: " + cryptocurrency);
        System.out.println("当前指标: " + metric);
        
        File folder = new File(IMAGE_BASE_PATH + cryptocurrency + "/" + metric);
        
        System.out.println("目标文件夹绝对路径: " + folder.getAbsolutePath());
        System.out.println("目标文件夹是否存在: " + folder.exists());
        System.out.println("目标是否为目录: " + folder.isDirectory());

        if (folder.exists() && folder.isDirectory()) {
            File[] files = folder.listFiles((dir, name) -> {
                String lowerName = name.toLowerCase();
                return lowerName.endsWith(".jpg") || lowerName.endsWith(".jpeg") 
                    || lowerName.endsWith(".png") || lowerName.endsWith(".gif");
            });

            if (files != null) {
                System.out.println("找到的图片数量: " + files.length);
                
                for (File file : files) {
                    // 生成相对路径
                    String path = "/static/blockchain-images/" + cryptocurrency + "/" + metric + "/" + file.getName();
                    
                    System.out.println("处理图片: " + file.getName());
                    System.out.println("生成的图片路径: " + path);
                    
                    images.add(new Image(file.getName(), path));
                }
            } else {
                System.out.println("文件列表为 null");
            }
        } else {
            System.out.println("错误：目录不存在或不是目录");
        }

        System.out.println("最终返回的图片数量: " + images.size());
        System.out.println("------- 调试信息结束 -------");
        
        return images;
    }
}