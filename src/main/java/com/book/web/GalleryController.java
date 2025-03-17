package com.book.web;

import com.book.domain.Image;
import com.book.domain.ImageCategory;
import com.book.service.GalleryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
public class GalleryController {
    
    private GalleryService galleryService;
    
    @Autowired
    public void setGalleryService(GalleryService galleryService) {
        this.galleryService = galleryService;
    }
    
    @RequestMapping("/gallery.html")
    public ModelAndView showGallery(@RequestParam(value = "category", required = false) String category) {
        ModelAndView modelAndView = new ModelAndView("gallery");
        
        List<ImageCategory> categories = galleryService.getAllCategories();
        modelAndView.addObject("categories", categories);
        
        List<Image> images;
        if (category != null && !category.isEmpty()) {
            images = galleryService.getImagesByCategory(category);
            modelAndView.addObject("selectedCategory", category);
        } else {
            images = galleryService.getAllImages();
        }
        
        modelAndView.addObject("images", images);
        
        return modelAndView;
    }
}