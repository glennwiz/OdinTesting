package main

/*
    Maxwell's Daemon, in Gnipahellir's depths, plays a cunning game,
    With points of memory as his pawns, in entropy's endless frame.
    Garm, the guardian fierce at Gnipahellir's gate, snarls at each move,
    Yet the Daemon defies, weaving past and present, in Gnipahellir's groove.

    Those who dare to fail miserably can achieve greatly
*/


import "core:fmt"
import "core:math/rand"
import "core:mem"

GRID_SIZE :: 64

// CellGrid defines a 64x64 grid of boolean values
CellGrid :: [GRID_SIZE][GRID_SIZE]Cell

r : ^[10]bool;

Cell :: struct {
    x: int,
    y: int,
    color: string,
    alive: bool,
}

main :: proc() {

    // 128 64 32 16   8 4 2 1
    // |-------octet--------|
    // |---nibble--|-nibble-|

    b1 := 0b0000_0001
    b2 := 0b0000_0010
    b4 := 0b0000_0100
    b8 := 0b0000_1000
    b16 := 0b0001_0000
    b32 := 0b0010_0000
    b64 := 0b0100_0000
    b128 := 0b1000_0000

    b9 := 0b0000_1111

    fmt.println("b1:", b1)
    fmt.println("b2:", b2)
    fmt.println("b4:", b4)
    fmt.println("b8:", b8)
    fmt.println("b16:", b16)
    fmt.println("b32:", b32)
    fmt.println("b64:", b64)
    fmt.println("128:", b128)

    fmt.println("b15:", b9)


    x : u32 = 0x24_2a_5d_4c
    x_bytes := transmute([4]byte)x

    fmt.printf("Default: \t%d = %x\t(%02x)\n", x, x, x_bytes) //endianess

    x_le : u32le  = 0x24_2a_5d_4c
    x_be : u32be  = 0x24_2a_5d_4c 

    x_le_bytes := transmute([4]byte)x_le
    x_be_bytes := transmute([4]byte)x_be

    fmt.printf("Little Endian: \t%d = %x\t(%02x)\n", x_le, x_le, x_le_bytes)
    fmt.printf("Big Endian: \t%d = %x\t(%02x)\n", x_be, x_be, x_be_bytes)




    fmt.println("-----------------------------------------")

    // Create a 64x64 grid of boolean values
    grid := CellGrid{}
    for i := 0; i < GRID_SIZE; i = i + 1 {
        for j := 0; j < GRID_SIZE; j = j + 1 {
            grid[i][j] = Cell{i , j, "blue", false}
        }
    }

    for i := 0; i < GRID_SIZE; i = i + 1 {
        for j := 0; j < GRID_SIZE; j = j + 1 {
            
            ptr: ^Cell
            ptr = &grid[i][j]

            //ptr.alive = false

            if rand.int_max(2) == 1 {
                ptr.alive = true
            }    

            /*
            hexadecimal decimal equivalent
            ----------- ------------------
            0           0
            1           1
            2           2
            3           3
            4           4
            5           5
            6           6
            7           7
            8           8
            9           9
            A           10
            B           11
            C           12
            D           13
            E           14
            F           15
            */
            size := size_of(Cell)
            // Use fmt.printf with %p to print the memory address
            //fmt.printf("Memory address of Struct Cell: %p\n", ptr)
            //fmt.printf("Size of cell in bytes: %d\n", size)
            //fmt.printf("Size of cell in bits: %d\n", size * 8)

            //B131FAFAA0 A0
            //B131FAFAC8 C8
            //A0 -> B0 = 16
            //B0 -> C0 = 16
            //C0 -> C8 = 8
            //8 + 16 + 16 = 40
            
        
        }
    }

    // Print the grid
    for i := 0; i < GRID_SIZE; i = i + 1 {
        for j := 0; j < GRID_SIZE; j = j + 1 {
            c := grid[i][j]
            if c.alive {
                fmt.print("#")
            } else {
                fmt.print(".")
            }
        }
        fmt.println("")
    }


    fmt.println("Random u32: ",rand.uint32());

    // Using local random number generator
    my_rand := rand.create(1)
    fmt.println(rand.uint32(&my_rand))
    fmt.println(rand.uint32(&my_rand))

    //get random 0 - 9 
    //https://pkg.odin-lang.org/core/math/rand/#int_max   
    fmt.println(rand.int_max(10))
    fmt.println(rand.int_max(10))
    fmt.println(rand.int_max(10))
    fmt.println(rand.int_max(10))
    fmt.println(rand.int_max(10))

    //get random 0 - 1
    fmt.println(rand.int_max(2))
    fmt.println(rand.int_max(2))
    fmt.println(rand.int_max(2))
    fmt.println(rand.int_max(2))
     
    value := 42             // An integer variable
    ptr := &value           // A pointer to the integer variable      

    fmt.println("Value before:", value)
    fmt.println("Pointer address:", ptr)

    ptr^ = 21               // Dereferencing the pointer and changing the value it points to
    fmt.println("Value after:", value)  
    fmt.println("1-----------------")

    i := 123 
    p: ^int                 // Declare a pointer to an integer
    p = &i                  // p now holds the address of i
    fmt.println("Memory address of i:", p) 
    fmt.println("Value of i through p:", p^) // Dereference p to read i's value
    p^ = 1337               // Modify i through the pointer p
    fmt.println("New value of i:", i) 

    fmt.println("2-----------------")

    cell_status := true
    p_cell := &cell_status  // Pointer to cell_status
    fmt.println("Memory address of cell_status:", p_cell)
    p_cell^ = false         // Modify cell_status through the pointer
    fmt.println("New value of cell_status:", p_cell^)

    fmt.println("3-----------------")

    // Demonstrating pointer usage with strings
    stringX := "Gemstones"
    p_string := &stringX    // Pointer to stringX
    p_string^ = "are"       // Modify stringX through the pointer
    p_string^ = "gems"      // Modify stringX again

    fmt.println("Should print 'gems':", stringX)
}
    