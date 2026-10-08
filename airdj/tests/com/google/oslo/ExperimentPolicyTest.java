package com.google.oslo;
public class ExperimentPolicyTest {
    private static int checks;
    private static void check(boolean value) { checks++; if (!value) throw new AssertionError("check "+checks); }
    public static void main(String[] args) {
        ExperimentPolicy p = new ExperimentPolicy();
        check(!p.active(0)); p.lease("a", 100); check(p.active(100));
        check(!p.active(6100)); p.lease("b", 200); p.end("a"); check(p.active(200));
        p.end("b"); check(!p.active(200));
        p.preview("a", 2, 140, 100); check(p.theme(1,100)==2 && p.tempo(100,100)==140);
        check(p.theme(1,8100)==1 && p.tempo(100,8100)==100);
        p.preview("b", 4, 100, 200); p.end("a"); check(p.previewing(200));
        p.end("b"); check(!p.previewing(200));
        p.lease("a", 10000); check(!p.active(0));
        check(ExperimentPolicy.style(99)==0 && ExperimentPolicy.speed(1)==50
                && ExperimentPolicy.speed(999)==200);
        p.preview("a",99,999,true,10000);
        check(p.theme(4,10000)==0 && p.tempo(100,10000)==200 && p.trails(false,10000));
        check(!p.trails(false,18000) && p.trails(true,18000));
        p.preview("a",1,100,false,20000); check(!p.previewing(10000));
        p.preview("",4,50,true,20001); check(p.theme(0,20001)==1);
        p.lease("a",20000); p.lease("a",25000); check(p.active(30000) && !p.active(31000));
        p.lease(null,30000); check(!p.active(31000));
        System.out.println("Experiment policy: "+checks+" checks passed");
    }
}
