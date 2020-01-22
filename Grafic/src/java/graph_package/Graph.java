/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package graph_package;

/**
 *
 * @author Юля
 */
public class Graph {
     double a;
     double b;
     int N;
     int k;
     double[] X; 
     double[] Y;

    public Graph(double a, double b, int N, int k) {
        this.a = a;
        this.b = b;
        this.N = N;
        this.k = k;
        X = new double[N];
        Y = new double[N];
    }
   
    public double get_X(int i)
    {
    return X[i];
    }
    public double get_Y(int i)
    {
    return Y[i];
    }

    public double getA() {
        return a;
    }

    public double getB() {
        return b;
    }

    public int getN() {
        return N;
    }
    
    
    public double f(double x){
        switch (k){
            case 0:
                 return Math.pow(x, 2) - 4;
            case 1:
                 return Math.pow(x, 3) - 27;
            case 2:
                 return Math.sin(x);
            case 3:
                return Math.cos(x);
            case 4:
                return Math.tan(x);
            default:
                 return Math.pow(x, 2) - 4;        
        }
    }
    public void Tab()
    {
        double h;
        double z;
        h = (b - a)/(N - 1);
        z = a;
        for(int i = 0; i < N; i++)
        {
            X[i] = z;
            Y[i] = f(X[i]); 
            z = z + h;
        }
    } 
   
}
