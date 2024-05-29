package eje1;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class RandomGeneralTreeGenerator {

    public static void main(String[] args) {
        Random random = new Random();
        int maxHeight = 5; // Altura máxima del árbol
        GeneralTree<Integer> randomTree = generateRandomTree(random, maxHeight);
        System.out.println("Árbol generado aleatoriamente:");
        printTree(randomTree);
    }

    public static GeneralTree<Integer> generateRandomTree(Random random, int maxHeight) {
        if (maxHeight <= 0 || random.nextInt(10) == 0) {
            return new GeneralTree<>(random.nextInt(100)); // Nodo hoja aleatorio
        } else {
            int numChildren = random.nextInt(4) + 1; // Número aleatorio de hijos entre 1 y 4
            List<GeneralTree<Integer>> children = new ArrayList<>();
            for (int i = 0; i < numChildren; i++) {
                children.add(generateRandomTree(random, maxHeight - 1));
            }
            return new GeneralTree<>(random.nextInt(100), children); // Nodo interno aleatorio
        }
    }

    public static void printTree(GeneralTree<Integer> tree) {
        printTree(tree, 0);
    }

    private static void printTree(GeneralTree<Integer> tree, int level) {
        if (tree == null) return;
        for (int i = 0; i < level; i++) {
            System.out.print("  ");
        }
        System.out.println(tree.getData());
        for (GeneralTree<Integer> child : tree.getChildren()) {
            printTree(child, level + 1);
        }
    }

}