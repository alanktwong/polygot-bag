{-
'hello, world' finally!

Compiling:
$ ghc --make helloworld  
[1 of 1] Compiling Main             ( helloworld.hs, helloworld.o )  
Linking helloworld ...

Now executing:
$ ./helloworld
-} 
main = do  
    putStrLn "Hello, what's your name?"  
    name <- getLine  
    putStrLn ("Hey " ++ name ++ ", you rock!")
