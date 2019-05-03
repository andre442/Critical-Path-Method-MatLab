Algoritmo elaborado para cálculo do caminha crítico no MatLab
Entradas devem estar no formato a seguir:

Entrada "a" (nomes e durações de cada atividade em formato .txt):

#
{
atividade1      #nome da atividade
3               #duração da atividade
}
{
atividade2      #nome da atividade
2               #duração da atividade
}
...


Entrada "b" (relação entre as atividades em formato .txt):

#
{
início
Atividade1
}
{
Atividade1
Atividade2
}
{
Atividade1
Atividade3
}
{
Atividade2
Atividade4
}
{
Atividade3
Atividade4
}
{
Atividade4
fim
}
