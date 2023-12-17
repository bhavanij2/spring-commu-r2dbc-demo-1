package com.example.springcommur2dbcdemo1.scorecard.dto;


import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class Item {
    private final String name;
    private final String category;
    private final String color;
    private final String shape;
}