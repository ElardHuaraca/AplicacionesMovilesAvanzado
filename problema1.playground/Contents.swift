import UIKit

for number in 1...100 {
    if (number>3) {
        if(number%1 == 0 && number%2 != 0 && number%3 != 0 && number%5 != 0 && number%number == 0){
            print("Primos: \(number)")
        }
    }else if(number > 1 && number < 4){
        print("Primos: \(number)")
    }
}

