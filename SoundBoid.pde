public class SoundBoid extends Boid{
    private SawOsc osc;
    private LowPass filter;
    private float freq;

    public SoundBoid(float x, float y, float m, float s, float f, PApplet parent){
        super(x, y, m, s, f);
        osc = new SawOsc(parent);
        filter = new LowPass(parent);
        freq = 1;
    }

    public void update(){

    }
}