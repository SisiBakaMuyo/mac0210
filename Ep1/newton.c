/*\__\__\__\__\__\__\__\__\__\__\__\__\__\__\__\__\__\__\__\__\__\__\__

  EP1 - MAC0210 - Parte 2 - Método de Newton

  Funcoes escolhidas:

  f(x) = x^3 - 5x + 1

  Nome: Isis Ardisson Logullo
  NUSP: 7577410

  para compilar o arquivo:
  gcc -Wall -o2 newton.c -o epp2 -lm

  \__\__\__\__\__\__\__\__\__\__\__\__\__\__\__\__\__\__\__\__\__\__\__*/

#include <stdio.h>  
#include <stdlib.h> 
#include <stdbool.h>
#include <math.h>

/* evalf(x): calcula o valor da função f aplicada em x */
double evalfx(double x){
    double f;
    f = pow(x,3) - 5 * x + 1;
    return f;
}

/* evalDf(x): calcula o valor da derivada da função f aplicada em x */
double evalDfx(double x){
    double d;
    d = (3 * pow(x,2)) - 5;
    return d;
}

/* newton (x 0 ): aplica o método de Newton para achar uma raiz da função f (com primeira
derivada f 0 ), partindo do ponto x 0
Usa a tolerancia e a raiz para limitar o calculo de parada .*/
double newton(double x0, double tol, double r){
    double x1 = x0;
    double x2 = x1;
    double Fx = evalfx(x1);
    double DFx = evalDfx(x1);
    double DeltaX;
    int ite = 0;

    while (true){
        DeltaX = -Fx / DFx;
        x2 = x1 + DeltaX;
        x1 = x2;
        Fx = evalfx(x1);
        DFx = evalDfx(x1);
        ite++;

 
        if (ite > 1000000){
            return x1;
        }
        if (abs(r - x1) < tol){
            return x1;  
        }     
    }
}

/* newton_basins ( l, u, p): acha as bacias de convergência da função f no domínio
[l 1 , u 1 ] × [l 2 , u 2 ] e gera um arquivo output.txt que contém os dados para a geração
da imagem das bacias (pode usar gnuplot para gerar as imagens). Os dados gerados
preenchem uma imagem com p 1 × p 2 pixels. */
void newton_basis(double l, double u, double p, double div){
    FILE *ptxt;
    double n1, n2, n3, j, i, z, y;
    int t;
    t = 1;
    j = 0;
    y = l;
    ptxt = NULL;

    ptxt = fopen("output.txt", "w");
    if (ptxt == NULL){
        printf("Erro na abertura do arquivo :(\n");
    }

    fprintf(ptxt,"A imagem do gráfico tem intervalo [%i,%i] em x e [%i,%i] em y. A resolução é de %i x %i pixels\n", (int)l, (int)u, (int)l, (int)u, (int)p, (int)p);

    /* vasculha de -u até u andando de 0.01, na reta x os pontos para verificar
    a sua convergencia e associa sua respectiva cor.
    Essa funcao gera um arquivo txt com o comando do plot associado a cada cor 
    para o octave.
    ex: 1,2,'b', 1,3,'r'... aqui o ponto (1,2) sera azul, (1,3) sera vermelho ...*/
    for (i = 0; i < (2*(abs(u)/div) + 1); i ++){
        
        for (z = 0; z < (2*(abs(l)/div) +1); z++){
            
            n1 = newton((l + j), 10^-6, -2.3301);
            n2 = newton((l + j), 10^-6, 0.20164);
            n3 = newton((l + j), 10^-6, 2.1284);
            if (abs(-2.3301 - n1) == 0){
                fprintf(ptxt, "%f , %f, 'y', ", (l + j), y);
            }
            else if (abs(0.20164 - n2) == 0){
                fprintf(ptxt, "%f , %f, 'b', ", (l + j), y);
            }
            else if (abs(2.1284 - n3) == 0){
                fprintf(ptxt, "%f , %f, 'g', ", (l + j), y);
            }
            else{
                fprintf(ptxt, "%f , %f, 'r', ", (l + j), y);
            }
            printf("Gerando Arquivo... %i de %i\n", (int)(t), (int)((2*(abs(u)/div) + 1)*(2*(abs(l)/div) +1)));
            t++;
            j = j + div;
        }    
        y = y + div;
        j = 0; 
        
    }     
    fclose(ptxt);
    printf("Arquivo output.txt gerado com sucesso!!\n");
}

int main(int argc, char *argv[]){
    
    double l, u, p, div;
    double r[3];

    printf("Temos um intervalo definido por [l,u].\n");
    printf("Digite o l do intervalo:\n");
    scanf("%le", &l);
    printf("Digite o u do intervalo:\n");
    scanf("%le", &u);
    printf("Digite o p da resolucao:\n");
    scanf("%le", &p);
    printf("Digite o valor para seccionar o intervalo. Ex: andar de 0.1, ou 0.01:\n");
    scanf("%le", &div);

    r[0] = newton(-2, 10^-6, -2.3301);
    r[1] = newton(0, 10^-6, 0.20164);
    r[2] = newton(2, 10^-6, 2.1284);
    
    if (r[0] == 0 || r[1] == 0 || r[2] == 0){
        printf("erro no calculo\n");
    }    
    else{
        newton_basis(l,u,p,div);
        printf("As raizes de f(x) = x^3 - 5*x + 1 sao:\n");
        printf("x1: %f\n", r[0]); 
        printf("x2: %f\n", r[1]);
        printf("x3: %f\n", r[2]);
    }

}
