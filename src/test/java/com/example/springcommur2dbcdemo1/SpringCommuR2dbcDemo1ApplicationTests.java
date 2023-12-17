package com.example.springcommur2dbcdemo1;

import com.example.springcommur2dbcdemo1.scorecard.dto.Item;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import io.vavr.collection.List;
import io.vavr.collection.Map;

@SpringBootTest
class SpringCommuR2dbcDemo1ApplicationTests {

	@Test
	void contextLoads() {
	}

	@Test
	public void testVavrGrouping() {
		List<Item> items = List.of(
				new Item("Apple", "Fruit", "Red", "Round"),
				new Item("Banana", "Fruit", "Yellow", "Curved"),
				new Item("Carrot", "Vegetable", "Orange", "Long"),
				new Item("Orange", "Fruit", "Orange", "Round"),
				new Item("Broccoli", "Vegetable", "Green", "Clustered"),
				new Item("Grapes", "Fruit", "Purple", "Clustered")
		);

		// Multi-level grouping by category, color, and shape
		Map<String, Map<String, Map<String, List<Item>>>> groupedItems = items.groupBy(Item::getCategory)
				.mapValues(categoryGroup -> categoryGroup.groupBy(Item::getColor)
						.mapValues(colorGroup -> colorGroup.groupBy(Item::getShape)));

		// Print the multi-level grouped items
		groupedItems.forEach((category, colorMap) ->
				colorMap.forEach((color, shapeMap) ->
						shapeMap.forEach((shape, itemList) ->
								System.out.println("Category: " + category +
										", Color: " + color +
										", Shape: " + shape +
										", Items: " + itemList)
						)
				)
		);
	}

}


