package com.study.carrotmarketserver;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

    @GetMapping("/hello")
    public String hello(){
        return "## hello success ##";
    }

    @GetMapping("/health")
    public String healthCheck(){
        return "health check";
    }
}
