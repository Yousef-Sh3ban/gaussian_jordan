import 'dart:math';

class GaussianJordan {
  // Method to perform Gaussian-Jordan elimination
  static String solve(
      List<List<double>> coefficientsMatrix, List<double> constantsMatrix) {
    String res = "";
    int rows = coefficientsMatrix.length;
    int cols = coefficientsMatrix[0].length;

    // Creating the augmented matrix
    List<List<double>> augmentedMatrix = List.generate(rows, (i) {
      return List<double>.from(coefficientsMatrix[i])..add(constantsMatrix[i]);
    });

    // Apply Gaussian-Jordan elimination
    for (int i = 0; i < min(rows, cols); i++) {
      // Find the row with the largest pivot
      int maxRow = i;
      for (int k = i + 1; k < rows; k++) {
        if (augmentedMatrix[k][i].abs() > augmentedMatrix[maxRow][i].abs()) {
          maxRow = k;
        }
      }

      // Check if the pivot is effectively zero
      if (augmentedMatrix[maxRow][i].abs() < 1e-9) {
        continue; // Move to the next column if no pivot is found
      }

      // Swap rows if needed
      if (maxRow != i) {
        List<double> temp = augmentedMatrix[i];
        augmentedMatrix[i] = augmentedMatrix[maxRow];
        augmentedMatrix[maxRow] = temp;
      }

      // Normalize the pivot row
      double pivot = augmentedMatrix[i][i];
      for (int j = 0; j < cols + 1; j++) {
        augmentedMatrix[i][j] /= pivot;
      }

      // Eliminate other entries in the current column
      for (int k = 0; k < rows; k++) {
        if (k == i) continue;
        double factor = augmentedMatrix[k][i];
        for (int j = 0; j < cols + 1; j++) {
          augmentedMatrix[k][j] -= factor * augmentedMatrix[i][j];
        }
      }
    }

    // Check for inconsistency or infinite solutions
    bool hasUniqueSolution = true;
    for (int i = 0; i < rows; i++) {
      bool allZero = true;
      for (int j = 0; j < cols; j++) {
        if (augmentedMatrix[i][j].abs() > 1e-9) {
          allZero = false;
          break;
        }
      }
      if (allZero && augmentedMatrix[i][cols].abs() > 1e-9) {
        res = "The system has no solution.";
        return res;
      } else if (allZero && augmentedMatrix[i][cols].abs() < 1e-9) {
        hasUniqueSolution = false;
      }
    }

    // Output the solution or identify free variables
    if (hasUniqueSolution) {
      res = "Unique Solution:";
      for (int i = 0; i < cols; i++) {
        res += "\nx${i + 1} = ${augmentedMatrix[i][cols].toStringAsFixed(4)}";
      }
      return res;
    } else {
      res = "Infinite Solutions or Free Variables:";
      return res;
      // for (int i = 0; i < cols; i++) {
      //   bool isFreeVariable = true;

      //   for (int j = 0; j < rows; j++) {
      //     if ((augmentedMatrix[j][i] - 1).abs() < 1e-9) {
      //       isFreeVariable = false;
      //       res += "\nx${i + 1} = ${augmentedMatrix[j][cols].toStringAsFixed(4)}";
      //       break;
      //     }
      //   }

      //   if (isFreeVariable) {
      //     res += "\nx${i + 1} is a free variable.";
      //   }
      // }
      // return res;
    }
  }
}

