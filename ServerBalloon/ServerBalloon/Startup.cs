using FirebaseAdmin;
using Google.Apis.Auth.OAuth2;

namespace ServerBalloon;

public class Startup
{
    public Startup(IConfiguration configuration)
    {
        Configuration = configuration;
    }

    private IConfiguration Configuration { get; }

    public void ConfigureServices(IServiceCollection services)
    {
        services.AddLogging();
        services.AddControllers();
        services.AddOptions();
        services.AddSwaggerGen();
        services.AddHealthChecks();
        services.AddLocalization();
        services.AddSingleton<FirebaseApp>(provider =>
        {
            return FirebaseApp.Create(new AppOptions()
            {
                Credential = GoogleCredential.FromFile("serverforballoon-firebase-adminsdk-cqngl-03e704bab4.json")
            });
        });
        var credential_path = "./serverforballoon-firebase-adminsdk-cqngl-03e704bab4.json";
        Environment.SetEnvironmentVariable("GOOGLE_APPLICATION_CREDENTIALS", credential_path);
    }

    public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
    {
        if (env.IsDevelopment()) app.UseDeveloperExceptionPage();
        app.UseHealthChecks("/health");
        app.UseAuthentication();
        app.UseRouting();
        app.UseSwagger();
        app.UseSwaggerUI();
       
        app.UseEndpoints(endpoints => { endpoints.MapControllers(); });
    }
}