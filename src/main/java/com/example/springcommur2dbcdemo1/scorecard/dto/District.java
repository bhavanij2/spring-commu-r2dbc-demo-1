package com.example.springcommur2dbcdemo1.scorecard.dto;

import lombok.Data;
import lombok.ToString;

import java.util.List;

@Data
@ToString
public class District {
    private String districtName;
    private List<Idn> idns;
}