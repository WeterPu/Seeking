public class SoundBoid extends Boid{
    private SawOsc osc;
    private LowPass filter;
    private float myFreq;

    public SoundBoid(float x, float y, float m, float s, float f, PApplet parent){
        super(x, y, m, s, f);
        osc = new SawOsc(parent);
        //filter = new LowPass(parent);
        myFreq = map(2, 6, 100, 300, mass);
        osc.play(myFreq, 0);
    }

    public void update(){
        super.update();
        osc.amp(map(0, 5, -.5, .5, vel.mag()));
    }
}