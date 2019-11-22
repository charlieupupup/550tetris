//pseudo code

//screen stands for the display
//block stands for the block module
//use merge function to merge them together

//for all bool func
//1 stands for true, nothing weird
//0 stands for false, something happens

#include "stdio.h"
#include "stdlib.h"

//basic setup for the screensize
//field is 22 * 22 = 484
//block is 4 * 4 = 16
//initialize

// 0 is nothing
// 1 is different type of tetris

// 9 is boundry #

void init(int *field)
{
    for (int i = 0; i < 484; i++)
    {
        field[i] = 0;
    }

    for (int i = 0; i < 22; i++)
    {
        field[i] = 9;
    }
    for (int i = 462; i < 484; i++)
    {
        field[i] = 9;
    }

    for (int i = 0; i < 22; i++)
    {
        field[i * 22] = 9;
    }

    for (int i = 0; i < 22; i++)
    {
        field[21 + i * 22] = 9;
    }
}

void printfield(int *field)
{
    for (int y = 0; y < 22; y++)
    {
        for (int x = 0; x < 22; x++)
        {
            if (field[y * 22 + x] == 9)
            {
                printf("#");
            }
            else if (field[y * 22 + x] == 0)
            {
                printf(" ");
            }
            else
            {
                printf("%d", field[y * 22 + x]);
            }
        }
        printf("\n");
    }
    printf("\n");
}

//check from bottom if certain row full and then clean it

void rowdown(int *field, int row)
{

    for (int y = row; y > 1; y--)
    {
        for (int x = 1; x < 21; x++)
        {
            field[y * 22 + x] = field[(y - 1) * 22 + x];
        }
    }
}

void rowfull(int *field, int *score)
{
    int full = 1;
    int y;
    int x;
    for (y = 20; y > 0; y--)
    {
        for (x = 20; x > 0; x--)
        {
            full = full * field[y * 22 + x];
        }
        if (full != 0)
        {
            rowdown(field, y);
            printfield(field);
            *score = *score + 100;
            y = y + 1;
        }
        full = 1;
    }
}

//check whether the block stop or not
//check whether the block hit the boundry
//check whether the block fit into other block or not
int blockcheck(int *block, int *screen, int xpos, int ypos, int r)
{

    for (int bx = 0; bx < 4; bx++)
    {
        for (int by = 0; by < 4; by++)
        {
            int blockindex = blockrotate(bx, by, r); //the index in the block

            int screenindex = (ypos + by) * 22 + xpos + bx; //the position in the screen

            if (xpos + bx < 21 & ypos + by < 21)
            {

                if (block[blockindex] != 0 & screen[screenindex] != 0)
                {
                    return 0;
                }
            }

            if (xpos + bx >= 21 | ypos + by >= 21)
            {
                if (block[blockindex] != 0)
                {
                    return 0;
                }
            }
        }
    }

    return 1;
}

//playfield
void fieldmerge(int *field, int *block, int xpos, int ypos, int r)
{

    for (int bx = 0; bx < 4; bx++)
    {
        for (int by = 0; by < 4; by++)
        {
            int blockindex = blockrotate(bx, by, r); //the index in the block

            int fieldindex = (ypos + by) * 22 + xpos + bx; //the position in the screen

            if (xpos + bx < 22 & ypos + by < 22 & field[fieldindex] == 0)
            {
                field[fieldindex] = block[blockindex];
            }
        }
    }
}

//refresh playfield with the backfield screen

void fieldrefresh(int *field1, int *field2)
{
    for (int i = 0; i < 484; i++)
    {
        field1[i] = field2[i];
    }
}

//motion control
//block move
//auto down
//left right
//detect touch
//calculate the index inmatrix
int blockrotate(int x, int y, int r)
{
    int index = 0;

    r = r % 4;

    if (r == 0)
    { //0
        index = y * 4 + x;
    }

    if (r == 1)
    { //90
        index = 12 + y - (x * 4);
    }

    if (r == 2)
    { //180
        index = 15 - (y * 4) - x;
    }

    if (r == 3)
    { //270
        index = 3 - y + (x * 4);
    }

    return index;
}

//merge the block and the screen

int main(void)
{

    //the small block of the tetrix

    int block1[16] = {0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0}; //I
    int block2[16] = {0, 0, 0, 0, 0, 2, 2, 0, 0, 2, 2, 0, 0, 0, 0, 0}; //square
    int block3[16] = {0, 0, 0, 0, 3, 3, 0, 0, 0, 3, 3, 0, 0, 0, 0, 0}; //z
    int block4[16] = {0, 4, 0, 0, 4, 4, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0}; //T
    int block5[16] = {5, 0, 0, 0, 5, 0, 0, 0, 5, 0, 0, 0, 5, 5, 0, 0};

    int *block = block1;

    //screensize
    int backfield[484];
    int playfield[484];

    //the place of the block
    int xpos = 7;
    int ypos = 1;

    //the rotation signal

    int r = 0;

    int score = 0;
    int *scoreptr = &score;
    //gamecheck

    init(backfield);
    fieldrefresh(playfield, backfield);
    printfield(playfield);

    //player
    int player = 1;

    while (blockcheck(block, backfield, xpos, ypos, r))
    {

        while (blockcheck(block, backfield, xpos, ypos, r)) //inner cycle for the current block
        {

            printf("score is:%d\n", score);
            printf("input motion:\n");
            char input[3];
            gets(input);
            if (!strcmp(input, "a") & blockcheck(block, backfield, xpos - 1, ypos, r))
            {
                xpos = xpos - 1;
            }
            if (!strcmp(input, "d") & blockcheck(block, backfield, xpos + 1, ypos, r))
            {
                xpos = xpos + 1;
            }
            if (!strcmp(input, "z") & blockcheck(block, backfield, xpos, ypos, r + 1))
            {
                r = r + 1;
            }

            fieldrefresh(playfield, backfield);

            fieldmerge(playfield, block, xpos, ypos, r);

            printfield(playfield);

            ypos = ypos + 1;
        }

        rowfull(playfield, scoreptr);

        fieldrefresh(backfield, playfield);

        //choose the next block
        r = (xpos + ypos + r) % 5;
        if (r == 0)
        {
            block = block1;
        }
        if (r == 1)
        {
            block = block2;
        }
        if (r == 2)
        {
            block = block3;
        }
        if (r == 3)
        {
            block = block4;
        }
        if (r == 4)
        {
            block = block5;
        }

        //init for next block
        xpos = 7;
        ypos = 1;
        r = 0;
    }

    fieldmerge(playfield, block, xpos, ypos, r);
    printfield(playfield);
    printf("you lose\n");
    return EXIT_SUCCESS;
}