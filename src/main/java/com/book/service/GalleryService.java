package com.book.service;

import com.book.domain.Image;
import com.book.domain.ImageCategory;
import org.springframework.stereotype.Service;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

@Service
public class GalleryService {
    
    // 图片存储的基本路径，需要根据你的实际情况修改
    private static final String IMAGE_BASE_PATH = "/Books-Management-System/src/main/webapp/static/images/";
    
    public List<ImageCategory> getAllCategories() {
        List<ImageCategory> categories = new ArrayList<>();
        categories.add(new ImageCategory("Class A", "classA"));
        categories.add(new ImageCategory("Class B", "classB"));
        return categories;
    }
    
    public List<Image> getImagesByCategory(String category) {
        List<Image> images = new ArrayList<>();
        
        File folder = new File(IMAGE_BASE_PATH + category);
        if (folder.exists() && folder.isDirectory()) {
            File[] files = folder.listFiles((dir, name) -> {
                String lowerName = name.toLowerCase();
                return lowerName.endsWith(".jpg") || lowerName.endsWith(".jpeg") 
                       || lowerName.endsWith(".png") || lowerName.endsWith(".gif");
            });
            
            if (files != null) {
                for (File file : files) {
                    String path = "/gallery/" + category + "/" + file.getName();
                    images.add(new Image(file.getName(), path));
                }
            }
        }
        
        return images;
    }
    
    public List<Image> getAllImages() {
        List<Image> allImages = new ArrayList<>();
        
        for (ImageCategory category : getAllCategories()) {
            allImages.addAll(getImagesByCategory(category.getFolderName()));
        }
        
        return allImages;
    }
}