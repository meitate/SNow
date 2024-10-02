

han <tree> leaf () {
  handle tree of {
  | ACCESS -> {
      select LEAF -> tree;
      close tree;
      stop;
    }
  | INSERT(value:int) ->
      start <$left> empty ();
      start <$right> empty ();
      now <tree,left,right> node (value);
  | INORDER -> 
      accept channel <- tree;
      handoff channel -> tree;
      accept channel <- left;
      send key 
  }
}

han <tree,left,right> node (key:int) {
  handle tree of {
  | ACCESS -> {
      select NODE(key) -> tree;
      handoff <left,right> -> tree;
      close tree;
      stop;
    }
  | INSERT(value:int) -> {
      when value = key {
        loop;
      } otherwise {
        when value < key {
          select INSERT(key) -> left;
          loop;
        } otherwise {
          select INSERT(key) -> right;
          loop;
        }
      }
    }
  | INORDER -> 
      accept channel <- tree;

      select INORDER -> left;
      handoff channel -> left;
      accept channel <- left;

      send key -> channel;

      select INORDER -> right;
      handoff channel -> right;
      accept channel <- right;

      handoff channel -> tree;
      loop;
  }
}

han <tree,tree1,tree2> merge () {
  select (ACCESS,ACCESS) -> <tree1,tree2>;
  handle <tree1,tree2> of {
  | (LEAF,LEAF) -> {
      await <tree1,tree2>;
      now <tree> leaf ();
    }
  | (NODE(key1:int),LEAF) -> {
      accept <left1,right1> <- tree1;
      await <tree1,tree2>;
      now <tree,left1,right1> node (key1);
    }
  | (NONE,NODE(key2:int)) -> {
      accept <left2,right2> <- tree2;
      await <tree1,tree2>;
      now <tree,left2,right2> node (key2);
    }
  | (NODE(key1:int),NODE(key2:int)) -> {
      accept <left1,right1> <- tree1;
      accept <left2,right2> <- tree2;
      await <tree1,tree2>;
      start <$tree2p,left2,right2> node (key2); 
      start <$left2p,$right2p,tree2p> splitBy (key1);
      start <$leftp,left1,left2p> merge ();
      start <$rightp,right1,right2p> merge ();
      now <tree,leftp,rightp> node (key1);
    }
  }
}

han <lessers,greaters,tree> splitBy (value:int) {
  select ACCESS -> tree;
  handle tree of {
  | LEAF -> {
      start <lessers> leaf ();
      start <greaters> leaf ();
      await tree;
    }
  | NODE(key:int) -> {
      accept <left,right> <- tree;
      when value <= key {
        start <$leftLessers,$leftGreaters,left> splitBy (value);
        link lessers <-> leftLessers;
        now <greaters,leftGreaters,right> node (key); 
      } otherwise {
        start <$rightLessers,$rightGreaters,right> splitBy (value);
        link greaters <-> rightGreaters;
        now <lessers,left,rightLessers> node (key);
      }
    }
  }
}        

  