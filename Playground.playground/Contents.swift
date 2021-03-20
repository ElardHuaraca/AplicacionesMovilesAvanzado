import UIKit

var x1,x2,a,b,c:Double!

a = 10;
b = 115;
c = 20;

x1 = (-b+(sqrt(pow(b, 2)-(4*a*c))))/(2*a);
x2 = (-b-(sqrt(pow(b, 2)-(4*a*c))))/(2*a);

print("Primer Resultado: \(x1!)")
print("Segundo Resultado: \(x2!)")
