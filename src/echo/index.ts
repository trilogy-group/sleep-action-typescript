/**
 * Sample action "echo" - remove/reuse if not required
 *
 * The following interfaces would match with your input/output schema as set on the DevFlows UI
 */
interface ActionInput {
  // Echo can have any kind of input
  body: unknown;
  headers?: {
    [key: string]: string;
  };
}

interface ActionOutput {
  statusCode: number;
  // Echo can have any kind of output in addition to standard errors
  body: string;
}

export const handler = async (input: string): Promise<ActionOutput> => {
  try {
    // Add business logic here
    const inputAsJson: ActionInput = JSON.parse(input);
    const { headers, body } = inputAsJson;

    // You can skip headers if you do not need them
    console.log(headers);

    return {
      statusCode: 200,
      body: JSON.stringify(body),
    };
  } catch (e) {
    console.log(e);
    console.error(e);

    return {
      statusCode: 500,
      body: JSON.stringify({
        errorMessage: e.message,
        errorType: "",
      }),
    };
  }
};

